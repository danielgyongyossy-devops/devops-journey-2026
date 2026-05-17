# AWS Terraform

This provisions the AWS side of the multi-cloud deployment:

- VPC with two public subnets
- ECR repository for the FastAPI image
- EKS cluster with a managed node group
- Existing GitHub Actions OIDC provider lookup and deployment role
- EKS access entry so the GitHub Actions role can deploy with Helm

## Usage

```bash
cd ".github/workflows/cloud-native-app/Terraform/aws terraform"
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

After apply, add this output to the repository secrets:

```bash
terraform output -raw github_role_arn
```

GitHub secret name:

```text
AWS_ROLE_ARN
```

The active workflow at `.github/workflows/ci-cd Multicloud.yml` uses that role to push to ECR and deploy the same Helm chart to EKS.

If your AWS account already has the GitHub OIDC provider at `https://token.actions.githubusercontent.com`, this Terraform reuses it instead of creating a duplicate.
