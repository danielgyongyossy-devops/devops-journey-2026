resource "google_container_cluster" "gke_cluster" {
  name       = var.cluster_name
  project    = var.project_id
  location   = var.zone
  depends_on = [var.network_subnet_dependency]

  initial_node_count       = var.initial_node_count
  remove_default_node_pool = true

  network    = var.vpc_name
  subnetwork = var.subnet_name

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "gke_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.gke_cluster.name
  project    = var.project_id
  node_count = var.initial_node_count

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    disk_size_gb = 50

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
}