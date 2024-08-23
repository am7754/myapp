variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
  default     = "festive-shield-433206-t8"
}

variable "region" {
  description = "The region where resources will be created."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = "my-gke-cluster"
}

variable "node_count" {
  description = "The number of nodes in the cluster."
  type        = number
  default     = 1
}

variable "node_machine_type" {
  description  = "The machine type for the cluster nodes."
  type         = string
  default      = "e2-medium"
  disk_size_gb = 100
  preemptible  = true
}
variable "repo_name" {
  description = "The name of the Artifact Registry repository"
  type        = string
  default     = "my-docker-repo"
}
