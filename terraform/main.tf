provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  initial_node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.node_machine_type
  }
}

output "kubeconfig" {
  value = google_container_cluster.primary.endpoint
}
