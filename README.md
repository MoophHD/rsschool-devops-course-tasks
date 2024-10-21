# AWS VPC Infrastructure and CI/CD Setup

This project uses Terraform to set up AWS VPC infrastructure and includes CI/CD configuration for automated deployments.

## Infrastructure Components

- VPC with 2 public and 2 private subnets in different Availability Zones
- Internet Gateway and NAT Gateway
- Security Groups and Network ACLs
- Bastion host for access to private resources
- Routing tables for traffic management

## Initial Setup

1. Create an S3 bucket for Terraform state:
   ```
   cd init
   terraform init
   terraform apply
   ```
2. Update `variables.tf` with your bucket name and region.

## Main Infrastructure Deployment

1. Install AWS CLI and Terraform
2. Clone this repository
3. Set up AWS credentials
4. Run:
   ```
   terraform init
   terraform plan
   terraform apply
   ```

## Project Structure

- `init/`: Initial setup for Terraform state bucket
- `bastion-host.tf`: Bastion host configuration
- `data.tf`: Data sources
- `github_oidc.tf`: GitHub OIDC configuration
- `main.tf`: Main configuration
- `nat.tf`: NAT Gateway setup
- `policies.tf`: IAM policies
- `roles.tf`: IAM roles
- `variables.tf`: Variable definitions
- `vpc.tf`: VPC and subnet configurations

## IAM Role Setup

- **GithubActionsRole**: Provides permissions for GitHub Actions
  - Permissions: EC2, Route53, S3, IAM, VPC, SQS, EventBridge (Full Access)
  - Trust Relationship: Configured for GitHub Actions OIDC provider

## CI/CD with GitHub Actions

The repository includes a workflow with three jobs:

1. `terraform-check`: Runs `terraform fmt`
2. `terraform-plan`: Executes `terraform plan`
3. `terraform-apply`: Applies changes (on merge to main)

## Security Considerations

- MFA enabled for root and IAM users
- GitHub Actions uses OIDC for AWS authentication
- Bastion host as the entry point for private resources
- Security groups and NACLs limit traffic

## Customization and Maintenance

- Modify `variables.tf` for custom configurations
- Use `terraform plan` to preview changes
- Apply changes with `terraform apply`
- Destroy infrastructure with `terraform destroy` when not needed
