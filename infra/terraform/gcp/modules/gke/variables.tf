variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}

variable "zone" {
  type        = string
  description = "GCP zone for the GKE cluster"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "initial_node_count" {
  type        = number
  description = "Initial number of nodes in the cluster"
  default     = 1
}

variable "machine_type" {
  type        = string
  description = "Machine type for nodes"
  default     = "e2-medium"
}

variable "network_subnet_dependency" {
  type        = string
  description = "Dependency on subnet to ensure network is created first"
}