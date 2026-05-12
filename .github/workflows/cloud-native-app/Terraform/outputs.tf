output "ecr_repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

output "eks_cluster_name" {
  value = aws_eks_cluster.app_cluster.name
}

output "github_role_arn" {
  value = aws_iam_role.github_actions.arn
}