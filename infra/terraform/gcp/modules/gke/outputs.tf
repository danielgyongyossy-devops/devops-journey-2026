output "cluster_id" {
  value       = google_container_cluster.gke_cluster.id
  description = "GKE cluster ID"
}

output "cluster_name" {
  value       = google_container_cluster.gke_cluster.name
  description = "GKE cluster name"
}

output "cluster_endpoint" {
  value       = google_container_cluster.gke_cluster.endpoint
  description = "GKE cluster endpoint"
}

output "cluster_ca_certificate" {
  value       = google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate
  sensitive   = true
  description = "Cluster CA certificate"
}


