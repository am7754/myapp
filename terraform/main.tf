provider "google" {
  credentials = jsondecode(base64decode(var.gcp_credentials_base64))
  project     = var.project_id
  region      = var.region
}

#resource "kubernetes_secret" "dockerhub_registry" {
#  metadata {
#    name = "dockerhub-secret"
#  }
#
#  data = {
#    ".dockerconfigjson" = base64encode(jsonencode({
#      auths = {
#        "https://index.docker.io/v1/" = {
#          username = var.docker_username
#          password = var.docker_password
#          email    = var.docker_email
#          auth     = base64encode("${var.docker_username}:${var.docker_password}")
#        }
#      }
#    }))
#  }
#
#  type = "kubernetes.io/dockerconfigjson"
#}


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

resource "google_container_node_pool" "primary_preemptible_nodes" {
  //name = "gke-my-gke-cluster-2-terraform-202408-cb68b8be-qmpn"
  cluster    = google_container_cluster.my-gke-cluster.name
  location   = google_container_cluster.my-gke-cluster.location
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.node_machine_type
  }
}

data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
}

provider "kubernetes" {
  host                   = data.google_container_cluster.primary.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_secret" "dockerhub_registry" {
  metadata {
    name      = "dockerhub-secret"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "https://index.docker.io/v1/" = {
          auth = base64encode("${var.docker_username}:${var.docker_password}")
        }
      }
    }))
  }

  type = "kubernetes.io/dockerconfigjson"
}
