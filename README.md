Here's an updated README that incorporates the new task while maintaining much of the original content:

# AWS VPC Infrastructure and K3s Cluster Setup

This project uses Terraform to set up AWS VPC infrastructure and deploy a K3s Kubernetes cluster.

## Infrastructure Components

- VPC with 2 public and 2 private subnets in different Availability Zones
- Internet Gateway and NAT Gateway
- Security Groups and Network ACLs
- Bastion host for access to private resources
- K3s Kubernetes cluster (1 control plane, 1 worker node)

## Initial Setup

1. Create an S3 bucket for Terraform state:
   ```
   cd init
   terraform init
   terraform apply
   ```
2. Update `variables.tf` with your bucket name and region.

## Main Infrastructure and K3s Cluster Deployment

1. Install AWS CLI and Terraform
2. Clone this repository
3. Set up AWS credentials
4. Run:
   ```
   terraform init
   terraform plan
   terraform apply
   ```

## K3s Cluster Verification

1. SSH into the bastion host and then into k3s-server
2. Run `kubectl get nodes` to verify cluster nodes
3. Deploy a simple workload:
   ```
   kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
   ```
4. Verify the workload is running:
   ```
   kubectl get pods
   ```

## Project Structure

- `init/`: Initial setup for Terraform state bucket
- `bastion-host.tf`: Bastion host configuration
- `k3s.tf`: K3s cluster configuration
- `vpc.tf`: VPC and subnet configurations
- Other configuration files (data.tf, variables.tf, etc.)

## IAM Role Setup

- **GithubActionsRole**: Provides permissions for GitHub Actions
- **K3sRole**: Provides necessary permissions for K3s nodes

## CI/CD with GitHub Actions

The repository includes a workflow for Terraform checks, plan, and apply.

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

## Monitoring

Basic monitoring is implemented using Prometheus and Grafana. Refer to the monitoring documentation for setup and usage details.
