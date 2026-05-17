output "repository_id" {
  value       = google_artifact_registry_repository.app_registry.repository_id
  description = "Artifact Registry repository ID"
}

output "repository_url" {
  value       = "${var.region}-docker.pkg.dev/${google_artifact_registry_repository.app_registry.project}/${google_artifact_registry_repository.app_registry.repository_id}"
  description = "Full Artifact Registry repository URL"
}