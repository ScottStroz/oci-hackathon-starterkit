#!/bin/bash
#set -x



echo "23.1.48.99 dev.mysql.com" >> /etc/hosts

# Install MySQL Community Edition 8.0
rpm -ivh https://dev.mysql.com/get/mysql84-community-release-$(uname -r | sed 's/^.*\(el[0-9]\+\).*$/\1/')-2.noarch.rpm
yum install -y mysql-shell --enablerepo=mysql-tools-innovation-community
yum install -y java-21-openjdk maven
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


