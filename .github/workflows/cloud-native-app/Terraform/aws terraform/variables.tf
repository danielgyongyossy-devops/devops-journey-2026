variable "region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
  default     = "cloud-native-app-cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "EKS Kubernetes version."
  default     = null
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range for the EKS VPC."
  default     = "10.20.0.0/16"
}

variable "ecr_repository_name" {
  type        = string
  description = "ECR repository name for the app image."
  default     = "cloud-native-app"
}

variable "node_instance_types" {
  type        = list(string)
  description = "EC2 instance types for the EKS managed node group."
  default     = ["t3.small"]
}

variable "node_min_size" {
  type        = number
  description = "Minimum EKS node count."
  default     = 1
}

variable "node_desired_size" {
  type        = number
  description = "Desired EKS node count."
  default     = 2
}

variable "node_max_size" {
  type        = number
  description = "Maximum EKS node count."
  default     = 3
}

variable "github_owner" {
  type        = string
  description = "GitHub repository owner or organization allowed to assume the AWS deployment role."
  default     = "danielgyongyossy-devops"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name allowed to assume the AWS deployment role."
  default     = "devops-journey-2026"
}

variable "github_branch" {
  type        = string
  description = "GitHub branch allowed to assume the AWS deployment role."
  default     = "main"
}
