# OCI Hackathon Starter Kit

Get your hackathon project running on Oracle Cloud Infrastructure (OCI). The starter kit deploys the networking, compute, and optional databases you need to start building an application.

## What the starter kit deploys

- **Networking:** A virtual cloud network (VCN), subnets, security lists, a NAT gateway, and an internet gateway.
- **Application server:** A compute instance with Java, Node.js, Python, and MySQL Shell installed.
- **Database options:** MySQL HeatWave, Autonomous Database, or both. The MySQL option includes HeatWave capabilities and MySQL REST Service (MRS).

You can deploy the infrastructure through OCI Resource Manager using the same modules provided in this repository.

This guide uses the stack ZIP from the [v1.6 release](https://github.com/ScottStroz/oci-hackathon-starterkit/releases/tag/v1.6).

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/ScottStroz/oci-hackathon-starterkit/releases/download/v1.6/oci-hackathon-starterkit-stack.zip)

For more background, see the [Starter Kit wiki](https://github.com/lefred/oci-hackathon-starterkit/wiki).

## Follow the guide

Complete steps 1–3 to deploy your environment and connect to the application server. Then choose the sections that fit your project. Steps 5, 7, and 8 require MySQL HeatWave.

1. [Create your OCI account](#1-create-your-oci-account)
2. [Deploy the starter kit](#2-deploy-the-starter-kit)
3. [Connect to the compute instance](#3-connect-to-the-compute-instance)
4. [Choose your application language](#4-choose-your-application-language)
5. [Connect to MySQL HeatWave](#5-connect-to-mysql-heatwave)
6. [Use OCI Generative AI](#6-use-oci-generative-ai)
7. [Use MySQL HeatWave GenAI](#7-use-mysql-heatwave-genai)
8. [Use MySQL REST Service](#8-use-mysql-rest-service)

Screenshots and sample version numbers illustrate the environment used to prepare this guide. Your console screens and installed versions may differ.

## 1. Create your OCI account

If you already have an OCI account, sign in and continue to step 2.

1. Open the [OCI sign-up page](https://signup.cloud.oracle.com/).
2. Enter your email address. If you registered for hackathon promotional credits, use the same address.
3. Follow the sign-up wizard and select **Individual** as your customer type.
4. Provide a supported payment method to verify your identity and activate the trial.

Oracle may place a temporary authorization hold on your card for verification. See the [Oracle Cloud Free Tier FAQ](https://www.oracle.com/cloud/free/faq/) for payment and trial details.

![OCI Signup](https://github.com/user-attachments/assets/ba9d41f1-5927-464f-b9f4-40b5174a8687)

![Customer Type](https://github.com/user-attachments/assets/c025e344-3bd7-4382-a4d5-ebe237a4a75d)

![Payment Method 1](https://github.com/user-attachments/assets/10be290f-aa3a-42d3-9a48-d496be6f799f)

![Payment Method 2](https://github.com/user-attachments/assets/7eed2f8a-cd7d-4b18-9163-068b3d26ecd7)

Once your account is ready, sign in to the OCI Console and check your trial status.

![OCI Console](https://github.com/user-attachments/assets/9ee3cbf7-e197-4486-a298-b1085e61d767)

## 2. Deploy the starter kit

With the OCI Console open, select **Deploy to Oracle Cloud** above or on the repository page. This opens the stack creation wizard in OCI Resource Manager.

![Deployment Button](https://github.com/user-attachments/assets/3c7896e9-eb8c-4040-98c9-f4938ac9991a)

![Resource Manager](https://github.com/user-attachments/assets/95cc9fb6-f325-454d-bce8-0a24d22c45d8)

### Choose your database

Select **MySQL HeatWave**, **Autonomous Database**, or **Both**.

| Option | What to configure |
| --- | --- |
| MySQL HeatWave | Enter your MySQL credentials and choose the database shape. The credential fields appear when you select this option. |
| Autonomous Database | Enter a database name that is unique in your tenancy and an ADMIN password. This stack uses a paid serverless configuration with 2 ECPUs and 20 GB of storage. |
| Both | Configure each database as described above. |

When MySQL HeatWave is selected, the stack defaults to the Always Free tier described in the original guide. You can choose a larger instance using trial or promotional credits. Review the selected configuration in the wizard before deploying.

![MySQL Shape](https://github.com/user-attachments/assets/c7893ce1-dab3-420b-89df-de78d7daae93)

### Configure the application server

The compute instance defaults to:

- **Shape:** `VM.Standard.E5.Flex`
- **OCPUs:** 1
- **Memory:** 4 GB

This is a paid AMD shape that can use trial or promotional credits. You can select another supported shape and adjust its OCPU and memory settings. OCI selects the fault domain automatically.

![Compute Shape](https://github.com/user-attachments/assets/ab2ba5d9-9d48-48f0-ad13-762becfcac9b)

### Create and apply the stack

1. Review your settings.
2. Select the option to **apply** the configuration.
3. Select **Create** to start deploying the resources.

![Apply Configuration](https://github.com/user-attachments/assets/2e0d18ea-3bb2-4a65-9ea1-ecfb8f5ea463)

The deployment takes several minutes. Follow the job progress in Resource Manager and wait for the job to succeed.

![Deployment Progress](https://github.com/user-attachments/assets/10a0c331-4fa8-4dad-90c3-e590cfda6d52)

![Deployment Complete](https://github.com/user-attachments/assets/ca1589ed-c422-46fa-b232-9eb0c5708cc5)

If the job fails, check its logs for the cause. For an **out-of-host-capacity** error, try another supported shape or retry later. E5 capacity is not guaranteed.

When deployment finishes, review the outputs at the end of the job logs. You'll use the connection details in the next steps.

![Deployment Output](https://github.com/user-attachments/assets/479e3840-7ccb-4369-8026-0bd50c063e01)

[Watch the deployment walkthrough](https://github.com/user-attachments/assets/3cda5c48-1189-4dc4-9036-b17ba17da71c)

## 3. Connect to the compute instance

You'll need the generated SSH private key and the compute instance's public IP address.

### Save the SSH key

1. In the OCI Console, open **Resource Manager → Stacks** and select your stack.
2. Open **Application Information → Generated SSH private key**.
3. Copy the entire key into a local file named `key.pem`.
4. Copy the compute instance's public IP address from the same screen.

![Generated SSH private key and compute connection details](https://github.com/user-attachments/assets/597dbf22-5619-45e7-b7d0-c3bfec142315)

![SSH private key saved to a local file](https://github.com/user-attachments/assets/69bd9d1c-a2a6-4bc9-9c8a-c6666c53dc88)

### Open an SSH connection

On macOS or Linux, restrict access to the key file:

```shell
chmod 600 key.pem
```

Then connect as the `opc` user. Replace `<compute-public-ip>` with your instance's public IP address:

```shell
ssh -i key.pem opc@<compute-public-ip>
```

![SSH Connection](https://github.com/user-attachments/assets/c0c62270-ac55-42ec-adb3-27bb89002e7e)

You're now connected to the application server. Unless a step says otherwise, run the remaining shell commands on this instance.

[Watch the SSH connection walkthrough](https://github.com/user-attachments/assets/75f96eed-cb99-4b56-b27d-7cdb51bb4c53)

## 4. Choose your application language

The compute instance includes Java, Node.js, and Python. The original guide's environment includes the following versions; check your instance before you start.

| Language | Versions shown in the original environment | Check your version |
| --- | --- | --- |
| Java | OpenJDK 17 and 21 | `java --version` |
| Node.js | 16 | `node --version` |
| Python | 3.9 | `python3 --version` |

### Switch Java versions

Use the alternatives system to select an installed Java version:

```shell
sudo update-alternatives --config java
java --version
```

At the prompt, enter the number for the version you want to use.

### Install Python 3.12

If your application needs Python 3.12, install it alongside the default version:

```shell
sudo dnf install -y python312
python3.12 --version
```

Use `python3.12` when running applications that require this version.

[Watch the language setup walkthrough](https://github.com/user-attachments/assets/c2bd05d5-2af0-4ea3-917e-9eca31b3c1b0)

## 5. Connect to MySQL HeatWave

**Prerequisite:** You selected MySQL HeatWave during deployment.

Choose one of these connection methods:

| Method | Where you connect from | What you need |
| --- | --- | --- |
| MySQL Shell | The compute instance | SSH access and the database's private IP address |
| MySQL Shell for Visual Studio Code | Your local machine | OCI API credentials and a bastion connection |
| OCI Cloud Shell | The OCI Console | An ephemeral private network connected to your VCN and private subnet |

### Option A: MySQL Shell on the compute instance

MySQL Shell is already installed. Connect to the compute instance over SSH, then connect to your MySQL HeatWave DB system using its private IP address and the credentials you supplied during deployment.

[Watch the MySQL Shell walkthrough](https://github.com/user-attachments/assets/3d4e3030-d350-4600-bb54-c3c16f7344a4)

### Option B: MySQL Shell for Visual Studio Code

On your local machine, create or update `~/.oci/config` with the OCI API key configuration for your user. Then use MySQL Shell for Visual Studio Code to connect to the DB system through a bastion host.

[Watch the Visual Studio Code walkthrough](https://github.com/user-attachments/assets/0940835d-7b26-4cb9-b96a-b11ecb29de54)

### Option C: OCI Cloud Shell

Open Cloud Shell from the OCI Console. Configure an **ephemeral private network** using your VCN and private subnet, then connect to the DB system using its private IP address.

[Watch the Cloud Shell walkthrough](https://github.com/user-attachments/assets/8fc02692-b81a-49f4-be8f-a8fe079b390e)

## 6. Use OCI Generative AI

OCI Generative AI lets you call models from your application using SDKs and generated sample code, including Java and Python examples.

### Generate sample code

1. In the OCI Console, open **Generative AI**.
2. Select a model available in your region.
3. Choose an example prompt or enter your own.
4. Copy the sample code for your preferred language.

![GenAI 01](https://github.com/user-attachments/assets/e6e51e37-c17b-450b-8c2d-a0ff254b4917)

![GenAI 02](https://github.com/user-attachments/assets/43440ac8-afa5-432e-b318-74c8e10ec6d8)

![GenAI 03](https://github.com/user-attachments/assets/4adf7541-5812-4afc-8506-f940f5a51e00)

![GenAI 04](https://github.com/user-attachments/assets/e762828d-5ea0-4d5d-98ac-e0b8efa3f3df)

### Run the example on your compute instance

Configure `~/.oci/config` on the compute instance with the credentials used by the sample code. This follows the same configuration approach as the Visual Studio Code connection in step 5, but the file must be available on the machine running the code.

![GenAI Usage 1](https://github.com/user-attachments/assets/a3dba008-4694-4591-9a07-5f59e24ee588)

Save the generated Python example as `demo.py`, install the dependencies it requires, and update the input prompt.

![GenAI Usage 2](https://github.com/user-attachments/assets/588b5351-6b1c-4c2d-b20e-1f53a7c7b752)

Run the example with the Python version you've configured:

```shell
python3 demo.py
```

![GenAI Usage 3](https://github.com/user-attachments/assets/65b77d2f-97aa-42b5-b04c-87a9bd2d3d46)

[Watch the OCI Generative AI walkthrough](https://github.com/user-attachments/assets/edb32d97-1532-44bf-a5b2-2269f7b24522)

## 7. Use MySQL HeatWave GenAI

**Prerequisite:** You deployed MySQL HeatWave and can connect to the DB system.

You can also call GenAI procedures directly from MySQL HeatWave. Start by checking that your application can connect to the database, then call the GenAI procedure.

### Install the Python connector

On the compute instance:

```shell
sudo dnf install -y pip
python3 -m pip install mysql-connector-python
```

Install the connector using the same Python interpreter you'll use to run your application.

### Test the database connection

Save this example as `test_hw.py`. Replace `<database-private-ip>`, `<mysql-user>`, and `<mysql-password>` with your deployment details.

```python
import mysql.connector

conn = mysql.connector.connect(
    host="<database-private-ip>",
    user="<mysql-user>",
    password="<mysql-password>",
)

cursor = conn.cursor()
cursor.execute("SELECT @@version")

for row in cursor.fetchall():
    print(row)

cursor.close()
conn.close()
```

Run it:

```shell
python3 test_hw.py
```

The script prints your database version. For example:

```text
('9.4.1-cloud',)
```

### Call HeatWave Chat

In the same script, replace the version query with:

```python
cursor.execute(
    "CALL sys.HEATWAVE_CHAT(%s)",
    ("What is MySQL HeatWave?",),
)
```

Run the script again to see the response.

![MySQL HeatWave GenAI](https://github.com/user-attachments/assets/1abff03a-29b2-49ce-b9ef-8e23b4b7fedf)

See the [MySQL HeatWave GenAI documentation](https://dev.mysql.com/doc/heatwave/en/mys-hw-genai.html) for available capabilities and requirements.

[Watch the MySQL HeatWave GenAI walkthrough](https://github.com/user-attachments/assets/c3f3eb3f-3260-406b-9fd2-bbf828747c90)

## 8. Use MySQL REST Service

**Prerequisite:** You deployed the MySQL option and configured MySQL Shell for Visual Studio Code as described in step 5.

The starter kit deploys MySQL REST Service (MRS) with the MySQL configuration. MRS exposes database resources through REST endpoints so your application can work with data without writing SQL for each request. It can also expose selected HeatWave GenAI functionality.

Review your deployment outputs for the service connection details:

![MRS New](https://github.com/user-attachments/assets/1b2ae153-0977-4375-ab61-18798bf0b2be)

<details>
<summary>Compare with the earlier deployment output</summary>

![MRS Previous](https://github.com/user-attachments/assets/598aebc0-1135-48c1-b9f2-0f9815347cef)

</details>

### Grant MRS administration access

Connect to MySQL as your database administrator and grant the MRS role. The examples below use the `admin` account; substitute your account name if it differs.

```sql
GRANT 'mysql_rest_service_admin' TO 'admin'@'%';
SET DEFAULT ROLE ALL TO 'admin'@'%';
```

Disconnect and reconnect to activate the role in your session.

### Create sample data

In MySQL Shell for Visual Studio Code, create a database and table, then insert three records:

```sql
CREATE DATABASE myproject;
USE myproject;

CREATE TABLE myrecords (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    inserted TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO myrecords (name)
VALUES ('Scott'), ('Miguel'), ('Fred');
```

### Expose the table through MRS

1. Create a REST service named **MyService** with the request path `/myService`.
2. Add the `myproject` schema and `myrecords` table to the service.
3. If prompted to add the schema while adding the table, select **Yes**.

![MRS Setup 1](https://github.com/user-attachments/assets/0364cee8-9cb3-4529-8129-97455c4d870f)

![MRS Setup 2](https://github.com/user-attachments/assets/d91373f5-ceb3-4272-b79a-b8cd8b5a6240)

![MRS Setup 3](https://github.com/user-attachments/assets/49950897-0dd3-4528-b36d-02a7e15a7180)

![MRS Setup 4](https://github.com/user-attachments/assets/f54062f2-8ade-4f4b-b7f7-0ed774d351d7)

![MRS Schema Prompt](https://github.com/user-attachments/assets/4dcdc4d2-ceb1-46f9-a66a-300c58f4a58b)

![MRS Schema Add](https://github.com/user-attachments/assets/40674588-9bad-4dae-94aa-21f242f1e753)

### Create a service user

With the default **MySQL** authentication app enabled, create the user you'll use to sign in to the service:

```sql
CREATE USER 'myrest' IDENTIFIED BY '<rest-password>';
```

Replace `<rest-password>` with your chosen password. Use the same password in the requests below.

### Access data with curl

On the compute instance, set the base URL to the MRS endpoint from your deployment outputs, including the `/myService` path:

```shell
MRS_BASE_URL='https://<mrs-host>/myService'
```

Authenticate and save the session cookie:

```shell
curl -c cookie.txt -k -X POST \
  -H 'Content-Type: application/json' \
  -d '{"username":"myrest","password":"<rest-password>","authApp":"MySQL"}' \
  "$MRS_BASE_URL/authentication/login"
```

Retrieve the records:

```shell
curl -s -b cookie.txt -k \
  "$MRS_BASE_URL/myproject/myrecords" | jq
```

The response contains the records and pagination metadata. To retrieve the record with ID `2`:

```shell
curl -s -b cookie.txt -k \
  "$MRS_BASE_URL/myproject/myrecords/2" | jq
```

For the sample data above, ID `2` corresponds to **Miguel**.

The walkthrough uses `-k` for the demo endpoint's TLS certificate. This option skips certificate verification.

[Watch the MRS setup walkthrough](https://github.com/user-attachments/assets/8b7fc207-44a5-44db-8c64-399bbd878f2c)

### Access data with the Python SDK

You can generate an SDK for your REST service in MySQL Shell for Visual Studio Code.

1. Download the SDK for **MyService**.
2. Select **Python** and set the service URL to the endpoint your compute instance can reach.
3. Copy the downloaded SDK folder to the compute instance.

![SDK Download](https://github.com/user-attachments/assets/fa369b46-f616-4715-b010-b1b10d60c010)

![SDK Config](https://github.com/user-attachments/assets/968ad3ae-f11d-4b02-8712-fb9addefe231)

![SDK Package](https://github.com/user-attachments/assets/9c73e0c3-ec9b-4a0f-a3a8-ca1007db5b56)

The commands below assume the downloaded folder is named `myService.mrs.sdk`. Substitute the actual folder name if yours differs.

Run this command on your **local machine**:

```shell
scp -i key.pem -r myService.mrs.sdk opc@<compute-public-ip>:
```

Then run these commands on the **compute instance**:

```shell
mkdir -p myproject
mv myService.mrs.sdk myproject/sdk
cd myproject
```

Install the dependencies listed in the generated SDK's instructions using Python 3.12.

Save your application as `project.py`. The example below follows the SDK layout and `read()` API shown in the original walkthrough:

```python
import asyncio

from sdk.my_service import MyService

my_service = MyService(verify_tls_cert=False)

async def main():
    await my_service.authenticate(
        username="myrest",
        password="<rest-password>",
    )

    records = await my_service.myproject.myrecords.read()
    for record in records:
        print(record.name)

    await my_service.myproject.myrecords.create(data={"name": "Lenka"})

asyncio.run(main())
```

Replace `<rest-password>` before running the script:

```shell
python3.12 project.py
```

The script prints the existing names and inserts a new record for Lenka. Running it again inserts another record.

**SDK version note:** Generated module paths and methods vary by SDK version. The current [MRS SDK reference](https://dev.mysql.com/doc/dev/mysql-rest-service/latest/sdk.html) documents `find()` for reading records and an `app` argument for authentication. If your generated SDK differs from the walkthrough, follow its included examples and matching API documentation.

Like `curl -k`, `verify_tls_cert=False` skips certificate verification for this demo connection.

[Watch the SDK walkthrough](https://github.com/user-attachments/assets/45e34c29-3eea-4804-a493-0736e0aedb1c)

## Additional resources

- [Starter Kit wiki](https://github.com/lefred/oci-hackathon-starterkit/wiki)
- [Stack ZIP and v1.6 release](https://github.com/ScottStroz/oci-hackathon-starterkit/releases/tag/v1.6)
- [Oracle Cloud Free Tier FAQ](https://www.oracle.com/cloud/free/faq/)
- [MySQL HeatWave GenAI documentation](https://dev.mysql.com/doc/heatwave/en/mys-hw-genai.html)
- [MRS quickstart](https://dev.mysql.com/doc/dev/mysql-rest-service/latest/quickstart.html)
- [MRS SDK reference](https://dev.mysql.com/doc/dev/mysql-rest-service/latest/sdk.html)
