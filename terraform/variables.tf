variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "google_credentials" {
  description = "Google Cloud service account credentials in JSON format"
  type        = string
}

variable "region" {
  description = "The region where resources will be created."
  type        = string
}

variable "cluster_region" {
  description = "The region where cluster will be created."
  type        = string
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the cluster."
  type        = number
}

variable "node_machine_type" {
  description = "The machine type for the cluster nodes."
  type        = string
  default     = "e2-medium"
}

variable "docker_username" {
  description = "Docker Hub username"
  type        = string
}

variable "docker_password" {
  description = "Docker Hub password or access token"
  type        = string
}

variable "docker_email" {
  description = "Docker Hub email"
  type        = string
}
variable "gcp_credentials_base64" {
  type        = string
  description = "Base64-encoded Google Cloud credentials JSON"
}
