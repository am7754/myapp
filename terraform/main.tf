provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "my-gke-cluster" {
  name                = var.cluster_name
  location            = var.cluster_region
  initial_node_count  = var.node_count
  deletion_protection = false

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 100
    preemptible  = true
  }
}

resource "google_artifact_registry_repository" "my_docker_repo" {
  repository_id = var.repo_name
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  cluster    = google_container_cluster.my-gke-cluster.name
  location   = google_container_cluster.my-gke-cluster.location
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.node_machine_type
  }
}
