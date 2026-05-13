resource "google_artifact_registry_repository" "app_registry" {
  project       = var.project_id
  location      = var.region
  repository_id = var.repository_id
  description   = "Docker container registry for cloud-native-app"
  format        = "DOCKER"

  docker_config {
    immutable_tags = false
  }
}