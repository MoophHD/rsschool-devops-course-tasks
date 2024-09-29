# AWS Infrastructure Setup

This repository contains Terraform configurations for setting up AWS resources.

## Initial Setup

Before deploying the main infrastructure, you need to create an S3 bucket to store the Terraform state. This is done using a separate "init" project.

### Creating the Terraform State Bucket

1. Navigate to the `init` directory:
```
cd init
```
2. Update the `variables.tf` file with your desired bucket name and region.

3. Run the following commands:
```
terraform init
terraform plan
terraform apply
```

## Main Infrastructure Components

After creating the state bucket, you can proceed with the main infrastructure setup:

1. S3 Bucket for Terraform State (created in the init step)
2. IAM Role for GitHub Actions (GithubActionsRole)

### IAM Role (GithubActionsRole)
- Purpose: Provides necessary permissions for GitHub Actions
- Permissions: EC2, Route53, S3, IAM, VPC, SQS, EventBridge (Full Access)
- Trust Relationship: Configured for GitHub Actions OIDC provider

## GitHub Actions Workflow

The repository includes a GitHub Actions workflow with three jobs:
1. `terraform-check`: Runs `terraform fmt` to check formatting
2. `terraform-plan`: Executes `terraform plan` to preview changes
3. `terraform-apply`: Applies the Terraform changes (on merge to main)

## Usage

1. Ensure AWS CLI and Terraform are installed locally
2. Clone the repository
3. Perform the initial setup to create the Terraform state bucket
4. Update `variables.tf` in the main project with your specific values, including the state bucket details
5. Run `terraform init` to initialize the main project
6. Use GitHub pull requests to propose and review changes
7. Merge to main to trigger automatic deployment

## Security

- MFA is enabled for both root and IAM users
- GitHub Actions uses OIDC for secure authentication with AWS

## Note

Ensure all sensitive information is stored securely and not committed to the repository.
