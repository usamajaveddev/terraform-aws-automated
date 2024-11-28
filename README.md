# Terraform Instance-VPC-S3-Bucket Automated Version
Modified version of my other repo: https://github.com/rcsfc/terraform-aws-vpc-ec2-s3

Read my 3 part series on Terraform starting with Part 1 here: https://www.linkedin.com/pulse/journey-towards-push-button-cloud-deployments-terraform-ronald-craft/

I wanted to take the original version and update it so that it would be easy to integrate into "push button" deployments while also allowing for multiple deployments to be deployed at the same time. 

This repo is used to show an example of how you might deploy an Ubuntu instance with a simple VPC, an S3 bucket pre-configured with a user and policy in IAM, and the auth key and secret uploaded as an encrypted text file directly to the S3 bucket when the deployment is complete. The idea behind this repo was to provide the user with a usable environment that is a bit more feature complete and secure than the typical barebones deployment of "just getting it to work". I also wanted to whitelist the user's IP address by default in SSH to avoid exposing the instance to the entire internet.

# Deploys the following:

- VPC
- Security Group with SSH for your current public IP as the only allowed ingress access
- Ubuntu t2.micro EC2 instance that will always pull the latest Ubuntu AMI
- S3 bucket with the private ACL setting and a new user created that has read, put and delete permissions (adjust to your needs)
- Versioning is enabled by default on the bucket to protect against accidental file deletion and overwriting. This is meant more for a production environment, so feel free to disable this feature if you don't want it.
- Force delete is disabled so that the S3 bucket won't be deleted if it has files in it
- An auth key and secret are generated and are uploaded to the S3 bucket with AES256 encryption and can be found in the file "access_keys.txt"

# How to use this repo
1. Install WSL2 on Windows 10/11 via: wsl --install
2. Ensure that AWS Cli and Terraform are installed in your WSL environment (Ubuntu by default)
3. Clone this repo to your home directory via: git clone https://github.com/rcsfc/terraform-aws-vpc-ec2-s3-automated.git
4. Invoke launch_instance.sh to create the environment and destroy_instance.sh to destroy the environment. You'll want to enter some project name for the resources when the terminal window pops up (i.e. tiger) and then hit enter. The rest of the process is automated

To facilitate the automation of this process you can use a hardware device such as the Elgato Streamdeck or a software macro program that maps the keys to your keyboard. If you go this route, the commands you'll want are as follows:

# Create the environment
wsl --cd ~ ./terraform-aws-vpc-ec2-s3-automated/launch_instance.sh

# Destroy the environment
wsl --cd ~ ./terraform-aws-vpc-ec2-s3-automated/destroy_instance.sh

If you change the paths then update the above accordingly. Otherwise, once these are mapped then you can create and destroy the environment with the push of a button. 
