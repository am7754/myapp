output "kubeconfig" {
  description = "The kubeconfig file for accessing the Kubernetes cluster."
  value       = google_container_cluster.primary.endpoint
}
