variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region for Artifact Registry"
}

variable "repository_id" {
  type        = string
  description = "ID/name of the Artifact Registry repository"
}