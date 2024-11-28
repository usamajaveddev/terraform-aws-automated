#!/bin/bash

# Function to display an error and exit
exit_with_error() {
    echo "Error: $1"
    exit 1
}

# Prompt the user for the project name
read -p "Enter the project name: " project_name

# Define paths
project_dir=~/terraform/$project_name
backup_dir=~/terraform/state_backups/$project_name
repo_url="https://github.com/rcsfc/terraform-aws-vpc-ec2-s3-automated.git"

# Create the project directory if it doesn't exist
if [ -d "$project_dir" ]; then
    exit_with_error "Project directory already exists. Exiting."
fi

mkdir -p "$project_dir" || exit_with_error "Failed to create project directory."

# Clone the repository and navigate to the project directory
cd "$project_dir" || exit_with_error "Failed to navigate to project directory."
git clone "$repo_url" . || exit_with_error "Failed to clone repository."

# Replace placeholder in configuration files
find . -type f -print0 | xargs -0 sed -i "s/CHANGEME/$project_name/g" || exit_with_error "Failed to update configuration files."

# Initialize and apply Terraform
terraform init || exit_with_error "Terraform initialization failed."
terraform apply -auto-approve || exit_with_error "Terraform apply failed."

# Backup Terraform state files
if [ -d "$backup_dir" ]; then
    exit_with_error "Backup directory already exists. Did you already create this project?"
fi

mkdir -p "$backup_dir" || exit_with_error "Failed to create backup directory."
find . -name "*.tfstate" -type f -exec cp {} "$backup_dir/" \; || exit_with_error "Failed to back up state files."

# Success message
echo "Project $project_name has been successfully deployed and state files are backed up."
exit 0
