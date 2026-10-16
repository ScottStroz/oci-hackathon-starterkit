#!/bin/bash
#set -x



echo "23.1.48.99 dev.mysql.com" >> /etc/hosts

# Install MySQL Community Edition 8.0
rpm -ivh https://dev.mysql.com/get/mysql84-community-release-$(uname -r | sed 's/^.*\(el[0-9]\+\).*$/\1/')-2.noarch.rpm
yum install -y mysql-shell --enablerepo=mysql-tools-innovation-community
# Install Maven first so any Java dependencies cannot override the default JDK.
yum install -y maven

# Install the latest Oracle JDK 27 build for the instance architecture.
case "$(uname -m)" in
  x86_64) jdk_arch=x64 ;;
  aarch64) jdk_arch=aarch64 ;;
  *) echo "Unsupported architecture for Oracle JDK 27: $(uname -m)" >&2; exit 1 ;;
esac
yum install -y "https://download.oracle.com/java/27/latest/jdk-27_linux-${jdk_arch}_bin.rpm" || exit 1

# The Oracle RPM maintains this symlink across JDK 27 updates.
alternatives --set java "$(readlink -f /usr/java/jdk-27/bin/java)" || exit 1
alternatives --set javac "$(readlink -f /usr/java/jdk-27/bin/javac)" || exit 1
echo 'export JAVA_HOME=/usr/java/jdk-27' > /etc/profile.d/java.sh

yum install -y npm
yum install -y httpd

# check if shell is installed and force manual installation
which mysqlsh > /dev/null 2>&1
if [ $? -eq 1 ]; 
then 
  rpm -ivh https://repo.mysql.com/yum/mysql-tools-innovation-community/el/$(uname -r | sed 's/^.*el\([0-9]\+\).*$/\1/')/x86_64/mysql-shell-9.5.0-1.$(uname -r | sed 's/^.*\(el[0-9]\+\).*$/\1/').x86_64.rpm
fi

echo "MySQL Shell successfully installed !"

firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --reload

chcon --type httpd_sys_rw_content_t /var/www/html
chcon --type httpd_sys_rw_content_t /var/www/html/*
setsebool -P httpd_can_network_connect_db 1
setsebool -P httpd_can_network_connect=1

systemctl enable httpd
systemctl start httpd

echo "Local Security Granted !"


