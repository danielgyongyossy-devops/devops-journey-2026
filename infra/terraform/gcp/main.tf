/* terraform {
  backend "gcs" {
    bucket = "terraform-state-devops-journey"
    prefix = "gcp"
  }
}
*/

# Network module: Create VPC and subnet
module "network" {
  source = "./modules/network"

  project_id  = var.project_id
  region      = var.region
  vpc_name    = "gke-vpc"
  subnet_name = "gke-subnet"
  subnet_cidr = "10.10.0.0/24"
}

# Artifact Registry module: Container registry
module "artifact_registry" {
  source = "./modules/artifact-registry"

  project_id    = var.project_id
  region        = var.region
  repository_id = var.registry_id
}

# GKE module: Kubernetes cluster (depends on network)
module "gke" {
  source = "./modules/gke"

  project_id                = var.project_id
  cluster_name              = var.cluster_name
  zone                      = var.zone
  vpc_name                  = module.network.vpc_name
  subnet_name               = module.network.subnet_name
  initial_node_count        = var.cluster_initial_node_count
  machine_type              = var.machine_type
  network_subnet_dependency = module.network.subnet_id
}
