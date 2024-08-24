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

resource "google_artifact_registry_repository" "my_docker_repo_2" {
  repository_id = var.repo_name
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
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
locals {
  gcr_json_key = "ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAiZmVzdGl2ZS1zaGllbGQtNDMzMjA2LXQ4IiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiMTkyZDM5Njc4ZmVhNmFiNmNlM2IyNTEyMmQxMmRjMjE0ZTM4YTk1YSIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZnSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2d3Z2dTa0FnRUFBb0lCQVFDYUpPMktrVi9IcXppelxuNlloMDlldHRRWFgvMXFxdXdlUGhkbnl5MVhVY1dod0M3a1RMUm4wZ2QvSXRCM2lzd0cvaHFxaGN3eEVXeGFzNFxuQzlFdloyNDlXdzQ3TkFXWURvaFNsVGRLczA3blBDNERpSWJkQ3dZTHBzRFQvcVgzcXhld0YrQnNpY3BZUVlDSVxuenhHZXJSNmdNZ29tUHRrRTBOTUVHV3NwMGlPTmV3aHZ0MGl3NXE1NkhidE9JNDNQRUdkOVUvNTZsUXNSWm5UVFxud2tZdzQ4UXhXVlFkWjR6MWJCR2hpVVZxT2UrZjFtdFk2SVdLRjFpM2pzVUxTY2g3V2RiZ29wV0NpWWloSEtuYlxuckxSV093MmVQRmtOTU5RMXlmVG1QL1MwTW4yTEJLRWNzeVdyTEE5N3UvcmZua3h1elNLUUtoZW1FN01RL2hhMFxub3FobEFkUjdBZ01CQUFFQ2dnRUFSalA3VzlqSjNvNUV6T3ZYa2kxT2cvd0VXZmpTMDdUS3JLemlMakM1bmFnTVxuaWVrcXU4bm13eHJkMlZSRnlhZjdUTFFFNmZxTmxlbUJDWTJZUUJiRFJuNXFCTnkwajRSTzRnM0RtT29CVFo5Q1xuOWFrQWd6dTZEU1J0UGlBRVJzQk5rWTNPVUtDUTM1RTFrUmw5MU43VHkvSCtYVnpTU2pjeFkvU1BzZ1JhM053dVxuODIxYml2TDdhREJyRU9tVWszWDB1ZUZQNnlubjJoblJzSFNVVkRDWFlTN0hKbFhtTm81NzY3cXRxaHpsZGwxRlxuOTQ2YXdBdzRmeHBBU2RJZUYwdjdYL0RhdWI1YjliRStBV3djVys2OE5KelpwSHBNeEV2aVZBOW5ZYjN5OWk0N1xudlhqY1ptdjBHbHlPMDBjZWVFZ1BlY2UvYWwwVy93UHp6UnB1dHFzc3dRS0JnUURONkhoTnFqbVVlVURPRFdqTlxuYW50TEs2bmtwVjM1NFprdTVIeUVPdVZENk9aS2xVMjF5Uzd4MHQ2Ykw0Vkl6VWcrNkYyVzdFTkhYRDFjWmpHU1xud0lzSzVhRk0ydXNFdmQrYmhLR1p5ZitSV2NUWGhYeWRRa2U3YnMwMjRYSlBDMDZpYk05MmdHNGFJN0cydC95aVxuamNJZnVWU0k2a0lydnRGcnhNaVAvQysvclFLQmdRQy9wTGFWaXZvclozb3BzTTR3NEl2N3VvWWhyMlNaNXBOM1xucVJoTFFHWUNiZHdteVQzQllrUTlKNzEwRFRGQ1JrakVjby9hUCtkN0lhaU4zaGVwWnJ6TUEvVU1MdXJWZ1FHOVxuMVNOcGhjR09mWG5zSlRWbm5Gem8rNFFTUnhNcUpBZ3RwL1dUbHhTNzNBeGlFbktDdEpmeWJMSE1tdzBCYTFTbFxuVFM2N2tKbkp4d0tCZ0IvY2tna0toeUJuWnRTN2xIVDh2aGxTcDFaZkZGeWZRUkhWZjBNQ3pna2xGOFdBdHVhalxuTytWbGlOYWdrdEpDR2FUS1Zma05sQmVOdVZ6NzN6M2pGMkRYU1k5WDdMZnVIWlMyQUQrSTEwZ0ppUUVFZ2RUZlxudGJQV0lHRVduNWFGbkdSYnkvcDlRd3crYTdoblhldFZYaTJFZ3dVd29vNmNWMUdDd0xvdS9zQjlBb0dCQUtLZ1xuWmdpVS9TSmtGempWdnNPZmFXcmVxQUJoMUY3OVdkckxkY0EyRDlxejI0UldkYjlyWWpqN1JqdjdEZmdOcUtaOFxuQ1RMTjArT2JkbXVkTWpzZzRjbkcrZVd5MHJrSFZyRCs4NlFTUzJSZGVsODRYQTlta3pscVpuTVVPV0VqWG9WUFxuNkllc1IzMzdoODZabE83eHpaZDlRWXc5YjFYcS9OT2hvYXl0VXJQMUFvR0JBTHZrcGFHUGNlbktKVFlxQ0VhL1xuS05wUGlIbWpjSXlEa0t4M1d6MmVFRXJiOWQwYmVxMGdnZUhPVXR6M1k5VUtiNm9TeGVoSFJLRGZjSlFYbFJpOFxuOUhpWkRUYnQxQk5rZEF5SnJzcmxqU3cwN0Fyb1poR1Qyd3A0QTVJaForZ0o3akdvdWs2aWhWZHcyaDNsUTBKT1xuZDkxMzFiRGpoRmhrWDNQc2VubzQ2cU0vXG4tLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tXG4iLAogICJjbGllbnRfZW1haWwiOiAiY2ljZC1hY2NvdW50LTNAZmVzdGl2ZS1zaGllbGQtNDMzMjA2LXQ4LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwKICAiY2xpZW50X2lkIjogIjEwNTM1NjY3NDc4OTE2MDcwMTcxNCIsCiAgImF1dGhfdXJpIjogImh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbS9vL29hdXRoMi9hdXRoIiwKICAidG9rZW5fdXJpIjogImh0dHBzOi8vb2F1dGgyLmdvb2dsZWFwaXMuY29tL3Rva2VuIiwKICAiYXV0aF9wcm92aWRlcl94NTA5X2NlcnRfdXJsIjogImh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL29hdXRoMi92MS9jZXJ0cyIsCiAgImNsaWVudF94NTA5X2NlcnRfdXJsIjogImh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL3JvYm90L3YxL21ldGFkYXRhL3g1MDkvY2ljZC1hY2NvdW50LTMlNDBmZXN0aXZlLXNoaWVsZC00MzMyMDYtdDguaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJ1bml2ZXJzZV9kb21haW4iOiAiZ29vZ2xlYXBpcy5jb20iCn0K"
}

resource "kubernetes_secret" "my_docker_secret" {
  metadata {
    name      = "my-docker-secret"
    namespace = "default" # Change if needed
  }
  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "us-central1-docker.pkg.dev" = {
          username = "_json_key"
          password = local.gcr_json_key
          email    = "cicd-account-3@festive-shield-433206-t8.iam.gserviceaccount.com"
          auth     = base64encode(format("%s:%s", "_json_key", local.gcr_json_key))
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}



