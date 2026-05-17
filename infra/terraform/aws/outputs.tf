output "ecr_repository_url" {
  description = "Full ECR repository URL used by the AWS deploy workflow."
  value       = aws_ecr_repository.app.repository_url
}

output "eks_cluster_name" {
  description = "EKS cluster name."
  value       = aws_eks_cluster.app.name
}

output "github_role_arn" {
  description = "Role ARN to store in the AWS_ROLE_ARN GitHub secret."
  value       = aws_iam_role.github_actions.arn
}

output "aws_region" {
  description = "AWS region for the EKS cluster and ECR repository."
  value       = var.region
}
