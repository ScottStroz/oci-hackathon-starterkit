# oci-hackathon-starterkit

Deploy on OCI to start developing an application.

The deployment contains all required network resources (VCN, Subnets, Security Lists, NAT Gateway, Internet Gateway, ...) , a compute instance as application server and an HeatWave MySQL Instance with HeatWave Cluster, Lakehouse and MySQL REST Service (MRS).

This initial infrastructure is an excellent starting point for a hackathon project.

The same modules are used as Resource Manager Stack.

The latest stack can be downloaded directly in the releases (the zip file)

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/ScottStroz/oci-hackathon-starterkit/releases/download/v1.4.1/oci-hackathon-starterkit-stack.zip)

Please check the [Wiki](https://github.com/lefred/oci-hackathon-starterkit/wiki) to learn how to use the Hackathon StarterKit.

## Getting Started

### 1. Create your OCI Account

Please go to [http://signup.cloud.oracle.com/](http://signup.cloud.oracle.com/)

If you have sent your email to get the free credits promotion, please use the same address to sign up.

You will get a similar screen after entering your email:

![OCI Signup](https://github.com/user-attachments/assets/ba9d41f1-5927-464f-b9f4-40b5174a8687)

Then follow the wizard and choose your customer type as an individual:

![Customer Type](https://github.com/user-attachments/assets/c025e344-3bd7-4382-a4d5-ebe237a4a75d)

You require a payment method (credit card) to enable your free trial, and you won't be charged, unless you upgrade your account:

![Payment Method 1](https://github.com/user-attachments/assets/10be290f-aa3a-42d3-9a48-d496be6f799f)

![Payment Method 2](https://github.com/user-attachments/assets/7eed2f8a-cd7d-4b18-9163-068b3d26ecd7)

When created and logged, you will see the OCI Console. Mind the message about using the Free Trial:

![OCI Console](https://github.com/user-attachments/assets/9ee3cbf7-e197-4486-a298-b1085e61d767)

### 2. Deploy the starterkit on OCI

To deploy the Hackathon Starter Kit on OCI, you need to be connected to the OCI console and click on the button on the GitHub Repo page.

![Deployment Button](https://github.com/user-attachments/assets/3c7896e9-eb8c-4040-98c9-f4938ac9991a)

You will then be redirected to the OCI Resource Manager Stack console:

![Resource Manager](https://github.com/user-attachments/assets/95cc9fb6-f325-454d-bce8-0a24d22c45d8)

Follow the wizard, choose an admin account and password, then you can also choose the shape for the compute and the MySQL DBSystem.

For the compute instance, the default is to use the `VM.Standard.A2.Flex` shape:

![Compute Shape](https://github.com/user-attachments/assets/ab2ba5d9-9d48-48f0-ad13-762becfcac9b)

However, you can choose another shape such as `VM.Standard.E2.1.Micro` if needed.

By default, the Stack also deploys the always-free Trier MySQL HeatWave. But you can also use your credits to deploy a more powerful instance:

![MySQL Shape](https://github.com/user-attachments/assets/c7893ce1-dab3-420b-89df-de78d7daae93)

When ready, make sure you check the apply box and click on "Create":

![Apply Configuration](https://github.com/user-attachments/assets/2e0d18ea-3bb2-4a65-9ea1-ecfb8f5ea463)

All the resources will start to be automatically deployed in OCI:

![Deployment Progress](https://github.com/user-attachments/assets/10a0c331-4fa8-4dad-90c3-e590cfda6d52)

This process takes some time; once finished, it should be green. If the job fails, it is likely related to the lack of capacity of the selected shapes:

![Deployment Complete](https://github.com/user-attachments/assets/ca1589ed-c422-46fa-b232-9eb0c5708cc5)

The job prints the output at the end of the logs:

![Deployment Output](https://github.com/user-attachments/assets/479e3840-7ccb-4369-8026-0bd50c063e01)

You can follow the entire deployment process on this video:

https://github.com/user-attachments/assets/3cda5c48-1189-4dc4-9036-b17ba17da71c

### 3. Connect to the compute instance

To connect to the deployed compute instance, you need to save the private SSH key that was created during the deployment.

This key is hidden and can be found in the "**Job resources**" of the Resource Manager's Stack details of the apply job:

![Job Resources 1](https://github.com/user-attachments/assets/c5b89686-e908-4f90-a91a-304df4fcc878)

![Job Resources 2](https://github.com/user-attachments/assets/517ddb90-b0d7-41af-801c-e0945e43b7aa)

![Job Resources 3](https://github.com/user-attachments/assets/b211e545-1220-4b91-8e67-f387536cdeb2)

Copy the key and paste it into a file on your disk. You need to fix the key by removing the enclosing double quotes and replacing all the '\n' with a real carriage return, using, for example, the command `:1,$s/\\n/\r/g` on Vi:

![Fix SSH Key](https://github.com/user-attachments/assets/18a110b1-ea11-4074-ab64-b1efec63e3ba)

Then you can change the file permissions to 600.

You can then connect to the compute instance using the key, the **opc** user and the public IP:

![SSH Connection](https://github.com/user-attachments/assets/c0c62270-ac55-42ec-adb3-27bb89002e7e)

You are now connected to the compute instance.

#### Update

Recently, when deploying a stack, there is a new tab with information on how to connect to the deployed compute instance:

![New Connection Tab 1](https://github.com/user-attachments/assets/7967304c-4ec6-4aad-97a8-b2189b0b273c)

![New Connection Tab 2](https://github.com/user-attachments/assets/d1b05ae4-c059-4628-aa83-6e6b7930a348)

You can select the content of the key and paste it into a file as previously, and we need to replace the blank spaces like this:

![Replace Spaces](https://github.com/user-attachments/assets/bbb95ccc-49e2-4d99-a9b2-9c36f4d5b249)

In Vim, I use the command:

`:s/\v^(\S+ ){3}\zs.*\ze( \S+){3}$/\=substitute(submatch(0), ' ', "\r", 'g')/`

You can also check this video:

https://github.com/user-attachments/assets/75f96eed-cb99-4b56-b27d-7cdb51bb4c53

### 4. Which application languages are available?

By default, the compute instance includes Java, NodeJS, and Python 3.

#### Java

The Java versions installed are OpenJDK 17 and 21.

The `alternatives` system can be used to switch versions:

```
$ java --version
openjdk 17.0.16 2025-07-15 LTS
OpenJDK Runtime Environment (Red_Hat-17.0.16.0.8-2.0.1) (build 17.0.16+8-LTS)
OpenJDK 64-Bit Server VM (Red_Hat-17.0.16.0.8-2.0.1) (build 17.0.16+8-LTS, mixed mode, sharing)

$ sudo update-alternatives --config java

There are 2 programs which provide 'java'.

  Selection    Command
-----------------------------------------------
*+ 1           java-17-openjdk.aarch64 (/usr/lib/jvm/java-17-openjdk-17.0.16.0.8-2.0.1.el9.aarch64/bin/java)
   2           java-21-openjdk.aarch64 (/usr/lib/jvm/java-21-openjdk-21.0.8.0.9-1.0.1.el9.aarch64/bin/java)

Enter to keep the current selection[+], or type selection number: 2

$ java --version
openjdk 21.0.8 2025-07-15 LTS
OpenJDK Runtime Environment (Red_Hat-21.0.8.0.9-1.0.1) (build 21.0.8+9-LTS)
OpenJDK 64-Bit Server VM (Red_Hat-21.0.8.0.9-1.0.1) (build 21.0.8+9-LTS, mixed mode, sharing)
```

#### NodeJS

The installed version of NodeJS is 16:

```
$ node --version
v16.20.2
```

#### Python 3

The default installed version of Python is 3.9:

```
$ python --version
Python 3.9.21
```

But you can also install manually a newer version (3.12):

```
$ sudo dnf install -y python312
...
$ python3.12 --version
Python 3.12.9
```

You can see this in the video:

https://github.com/user-attachments/assets/c2bd05d5-2af0-4ea3-917e-9eca31b3c1b0

### 5. Connect to MySQL HeatWave

You have multiple possibilities to connect to your MySQL HeatWave instance, and we will use three of them:

1. using MySQL Shell in the command line via the compute instance
2. using MySQL Shell for Visual Studio Code on your machine
3. using Cloud Shell

#### MySQL Shell in the command line

MySQL Shell is already installed on the Compute Instance. From it, when connected in SSH, you can launch MySQL Shell and connect to the MySQL HeatWave DBSystem using its private IP.

Check the video:

https://github.com/user-attachments/assets/3d4e3030-d350-4600-bb54-c3c16f7344a4

#### MySQL Shell for Visual Studio Code

If we configure the OCI config on our machine, we can use MySQL for Visual Studio Code to connect to the MySQL HeatWave DBSystem via a bastion host.

We need to create or update our `~/.oci/config` file to use a new API Key for our user.

Check the video with all the steps:

https://github.com/user-attachments/assets/0940835d-7b26-4cb9-b96a-b11ecb29de54

#### OCI Console's Cloud Shell

You can also use the Cloud Shell from the OCI Console to connect to your MySQL HeatWave DBSystem.

You need first to use an "Ephemeral private network" that uses your VCN and your private subnet:

Then you connect using the DBSystem's private IP, like in the video:

https://github.com/user-attachments/assets/8fc02692-b81a-49f4-be8f-a8fe079b390e

### 6. Use OCI GenAI

You can use OCI GenAI Service directly in your code.

We provide SDKs and sample code for several programming languages, including Java and Python.

From the OCI Console, we go to the GenAI section:

![GenAI 01](https://github.com/user-attachments/assets/e6e51e37-c17b-450b-8c2d-a0ff254b4917)

Depending on your region, you have access to different models:

![GenAI 02](https://github.com/user-attachments/assets/43440ac8-afa5-432e-b318-74c8e10ec6d8)

We provide examples, or you can leave it blank:

![GenAI 03](https://github.com/user-attachments/assets/4adf7541-5812-4afc-8506-f940f5a51e00)

Finally, you can copy the code for the programming language you prefer:

![GenAI 04](https://github.com/user-attachments/assets/e762828d-5ea0-4d5d-98ac-e0b8efa3f3df)

The example uses the `~/.oci/config` file with your settings (same as we did in MySQL Shell Studio Code, but this time on our compute instance):

![GenAI Usage 1](https://github.com/user-attachments/assets/a3dba008-4694-4591-9a07-5f59e24ee588)

We copied the code for Python, and we modified it just a little bit to add our input question:

![GenAI Usage 2](https://github.com/user-attachments/assets/588b5351-6b1c-4c2d-b20e-1f53a7c7b752)

Then we run the demo:

```
$ python demo.py
```

![GenAI Usage 3](https://github.com/user-attachments/assets/65b77d2f-97aa-42b5-b04c-87a9bd2d3d46)

Let's see all this in action in the video below:

https://github.com/user-attachments/assets/edb32d97-1532-44bf-a5b2-2269f7b24522

### 7. Use HeatWave GenAI

It's also possible to directly use GenAI capabilities from the MySQL HeatWave database.

When you are connected to the MySQL HeatWave instance you have deployed, you can call some HeatWave AI procedures from your program.

#### Connecting in Python to your DB System

To use MySQL in our Python application, we need to install the `python-mysql-connector`: 

```
[opc@webserver ~]$ sudo dnf install -y pip
[opc@webserver ~]$ pip install mysql-connector-python
```

We already saw how we can connect, now let's connect from an application (a minimal Python script running on our compute instance):

```
import mysql.connector

conn = mysql.connector.connect(
        host = "10.0.1.57",
        user = "admin",
        password = "xxxxxxx"
        )

cursor = conn.cursor()

cursor.execute("select @@vewrsion")
rows = cursor.fetchall()

for row in rows:
    print(row)
```

And when we run it, we can see:

```
[opc@webserver ~]$ python test_hw.py 
('9.4.1-cloud',)
```

#### Using HeatWave GenAI

We can do the same using a GenAI function provided by MySQL HeatWave:

```
import mysql.connector

conn = mysql.connector.connect(
        host = "10.0.1.57",
        user = "admin",
        password = "xxxxxxxx"
        )

cursor = conn.cursor()

cursor.execute("call sys.HEATWAVE_CHAT(\"What is MySQL HeatWave?\")")
rows = cursor.fetchall()

for row in rows:
    print(row)
```

And this is the output:

![HeatWave GenAI](https://github.com/user-attachments/assets/1abff03a-29b2-49ce-b9ef-8e23b4b7fedf)

#### More Info

* https://dev.mysql.com/doc/heatwave/en/mys-hw-genai.html

Let's recap in video:

https://github.com/user-attachments/assets/c3f3eb3f-3260-406b-9fd2-bbf828747c90

### 8. Use MySQL REST Service (MRS)

The starter kit deploys the MySQL REST Service automatically on OCI.

This is the previous output:

![MRS Previous](https://github.com/user-attachments/assets/598aebc0-1135-48c1-b9f2-0f9815347cef)

And this is the new one:

![MRS New](https://github.com/user-attachments/assets/1b2ae153-0977-4375-ab61-18798bf0b2be)

This enables us to provide access to data without requiring SQL. It also provides access to some Gen AI functionalities available in MySQL HeatWave.

#### Adding data to MRS using Visual Studio Code

To be able to use the MRS functionalities available in MySQL Shell for Visual Studio Code, we need to grant some privileges to our admin user:

```
sql> GRANT 'mysql_rest_service_admin' TO 'admin'@'%';
sql> SET DEFAULT ROLE ALL TO 'admin'@'%';
```

_It's recommended to close the connection and reconnect for immediate grants_

We will use MySQL Shell for Visual Studio Code to create a new table and provide access to it using MRS.

```
sql> create database myproject;
sql> use myproject
sql> create table myrecords (id int unsigned auto_increment primary key, 
                             name varchar(20),
                             inserted timestamp default current_timestamp);
sql> insert into myrecords values ('Scott'), ('Miguel'), ('Fred');
```

Then we need to add the schema and the table to the service:

![MRS Setup 1](https://github.com/user-attachments/assets/0364cee8-9cb3-4529-8129-97455c4d870f)

We call our service "MyService" and it's accessible using the path /myService:

![MRS Setup 2](https://github.com/user-attachments/assets/d91373f5-ceb3-4272-b79a-b8cd8b5a6240)

![MRS Setup 3](https://github.com/user-attachments/assets/49950897-0dd3-4528-b36d-02a7e15a7180)

Then we need to add the schema and the table to the service:

![MRS Setup 4](https://github.com/user-attachments/assets/f54062f2-8ade-4f4b-b7f7-0ed774d351d7)

Since the schema hasn't been added to the service (we used a shortcut), MySQL Shell prompts us to add it. We say "yes":

![MRS Schema Prompt](https://github.com/user-attachments/assets/4dcdc4d2-ceb1-46f9-a66a-300c58f4a58b)

![MRS Schema Add](https://github.com/user-attachments/assets/40674588-9bad-4dae-94aa-21f242f1e753)

We also need to create a user to access our service. By default, the **MySQL App** is enabled.

```
sql> create user myrest identified by 'myrestPassw0rd!';
```

#### Accessing data using curl 

In our compute instance, we can try to access our REST service using curl.

We need first to create a cookie (the easiest method with curl):

```
$ curl -c cookie.txt -k  -X POST  -H "Content-Type: application/json" \
   -d '{"username": "myrest",
        "password": "myrestPassw0rd!",
        "authApp": "MySQL" }' \
  https://10.0.1.57/myService/authentication/login
{}
$ curl -s -b cookie.txt -k -X GET  https://10.0.1.57/myService/myproject/myrecords | jq
{
  "items": [
    {
      "id": 1,
      "name": "Scott",
      "links": [...],
      "inserted": "2025-09-25 09:52:39.000000",
      "_metadata": {...}
    }
  ],
  "limit": 25,
  "offset": 0,
  "hasMore": false,
  "count": 3,
  "links": [...]
}
```

We can also specify a single record:

```
$ curl -s -b cookie.txt -k -X GET  https://10.0.1.57/myService/myproject/myrecords/2 | jq
{
  "id": 2,
  "name": "Fred",
  "links": [...],
  "inserted": "2025-09-25 09:52:39.000000",
  "_metadata": {
    "etag": "3E8174FCE3DBB38F0FA331E36460F9299C950522809213CC41A7AF954D0E83C4"
  }
}
```

Check the video to see the different steps in action:

https://github.com/user-attachments/assets/8b7fc207-44a5-44db-8c64-399bbd878f2c

#### Using the SDK

We can also use the SDK, which is very simple.

We start by downloading the SDK of our service:

![SDK Download](https://github.com/user-attachments/assets/fa369b46-f616-4715-b010-b1b10d60c010)

I modified the default address and selected Python language for the SDK:

![SDK Config](https://github.com/user-attachments/assets/968ad3ae-f11d-4b02-8712-fb9addefe231)

![SDK Package](https://github.com/user-attachments/assets/9c73e0c3-ec9b-4a0f-a3a8-ca1007db5b56)

We copy that downloaded folder in our compute instance, and we need to rename it as sdk:

```
[laptop]$ scp -i key.pem -r v1.mrs.sdk opc@<public_ip_of_the_compute>:

[compute]$ mkdir myproject
[compute]$ mv myService.mrs.sdk myproject/sdk
[compute]$ cd myproject
```

And we create our Python application:

```
from sdk.my_service import *

my_service = MyService(verify_tls_cert=False)

async def main():
    await my_service.authenticate(
            username = "myrest",
            password = "myrestPassw0rd!",
            )
    records = await my_service.myproject.myrecords.read()
    for record in records:
        print(record.name)
    await my_service.myproject.myrecords.create(data={"name": "Lenka"})

asyncio.run(main())
```

And we can run it:

```
[opc@webserver myproject]$ python3.12 project.py 
Scott
Fred
Miguel
```

Check the video to see how to use the SDK:

https://github.com/user-attachments/assets/45e34c29-3eea-4804-a493-0736e0aedb1c

#### More Info

* https://dev.mysql.com/doc/dev/mysql-rest-service/latest/quickstart.html
* https://dev.mysql.com/doc/dev/mysql-rest-service/latest/sdk.html
