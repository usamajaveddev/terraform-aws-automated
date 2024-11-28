#!/bin/bash

# Function to display an error and exit
exit_with_error() {
    echo "Error: $1"
    exit 1
}

# Prompt the user for the project name to destroy
read -p "Enter the project name to DESTROY: " project_name

# Define paths
project_dir=~/terraform/$project_name
backup_dir=~/terraform/state_backups/$project_name
ssh_key_path=~/.ssh/"${project_name}_ssh_key.pub.pem"

# Check if the project directory exists
if [ ! -d "$project_dir" ]; then
    exit_with_error "Project directory not found. Exiting."
fi

# Navigate to the project directory
cd "$project_dir" || exit_with_error "Failed to navigate to project directory."

# Run Terraform destroy
terraform destroy -auto-approve || exit_with_error "Terraform destroy failed."

# Remove SSH key associated with the project, if it exists
if [ -f "$ssh_key_path" ]; then
    rm -f "$ssh_key_path" || exit_with_error "Failed to delete SSH key."
fi

# Remove backup files associated with the project
if [ -d "$backup_dir" ]; then
    rm -fr "$backup_dir" || exit_with_error "Failed to delete backup directory."
fi

# Remove the project directory
rm -fr "$project_dir" || exit_with_error "Failed to delete project directory."

# Success message
echo "Project $project_name has been DESTROYED. System powering down..."
exit 0
