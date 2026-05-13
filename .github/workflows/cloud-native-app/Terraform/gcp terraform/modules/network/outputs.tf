output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "ID of the VPC"
}

output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "Name of the VPC"
}

output "subnet_id" {
  value       = google_compute_subnetwork.subnet.id
  description = "ID of the subnet"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "Name of the subnet"
}