# AUTOMATION-PROJECT
This project helps you automate the deployment of your containerized application to your cluster using different modern technologies.
## Technologies Used

**Docker**: Containerization of applications.

**Terraform**: Infrastructure as Code (IaC) for provisioning resources.

**Git**: Version control system for working locally.

**GitHub Actions**: CI/CD pipeline automation.

**AWS**: Cloud platform for hosting the infrastructure.

## Setup Instructions
### Prerequisites
#### **Firstly**, ensure you have the following installed locally on your machine:

**1. Git**

```bash
sudo yum install git      
```


**2. Docker**

```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
sudo systemctl enable docker
sudo systemctl start docker    
```

**3. Terraform**
```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum install terraform    
```
**4. AWS CLI**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install      
```
#### **Secondly**, ensure you create the following from your AWS console:

**1.  S3 bucket**: Store your remote backend(terraform state file).

**2.DynamoDB**: For state file locking 

**3. I am user**: I am user with admin permissions and create an access key.

#### **Lastly**, set up your credentials:

**1. Github Actions**
 
Scroll down in the settings tab of your repository, tap on Secrets and Variables, select Actions 
![7](https://github.com/user-attachments/assets/f72c7ee8-db11-4421-87f1-5736eeab8f9b)

Add your AWS Credentials as secrets

![8](https://github.com/user-attachments/assets/23073f16-037f-4581-a057-c48fc37784ea)

**2. Locally**

```bash
AWS Configure       
```

![9](https://github.com/user-attachments/assets/bba434fa-8e98-4078-8c9f-74a42d2ec58b)

## Usage

After setting up everything, you can now start using this repo!

**Clone the Repository**

```bash
git clone https://github.com/shazamohmd/AUTOMATION-PROJECT.git
cd AUTOMATION-PROJECT     
```

#### Update the Terraform files with your desired configurations(you can also replace with your own Dockerfile).


#### Trigger the CI/CD workflow by committing your changes

## Workflows 
### CI/CD 
This workflow handles the following:

**1. Lint the application code**

**2. Build a Docker image for the application**

**3. Upload the image to AWS ECR**

**4. Update the mage URI in the variables file**

**5. Deploy the required infrastructure using Terraform to host the application:**

* Creates an ECS Cluster

* Configures needed networks (VPC, Public subnet, Internet Gateway, Security Groups)

* Creates a Task definition with the desired configuration

* Executes the task with the image from ECR

**6. Set the image URI back to the default for future runs of this workflow**

### Terraform-Destroy

This workflow handles destroying all the AWS resources by triggering it manually.

**Note: You must stop running containers from the AWS console before running this workflow.**


