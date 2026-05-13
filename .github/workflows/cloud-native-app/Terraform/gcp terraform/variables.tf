variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "GCP zone for GKE cluster"
  default     = "us-central1-a"
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
  default     = "cloud-native-app-cluster"
}

variable "cluster_initial_node_count" {
  type        = number
  description = "Initial node count for GKE cluster"
  default     = 1
}

variable "machine_type" {
  type        = string
  description = "Machine type for GKE nodes"
  default     = "e2-medium"
}

variable "registry_id" {
  type        = string
  description = "Artifact Registry repository ID"
  default     = "cloud-native-app"
}