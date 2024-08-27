provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_secret" "dockerhub_registry" {
  metadata {
    name = "dockerhub-secret"
  }

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "https://index.docker.io/v1/" = {
          username = var.docker_username
          password = var.docker_password
          email    = var.docker_email
          auth     = base64encode("${var.docker_username}:${var.docker_password}")
        }
      }
    }))
  }

  type = "kubernetes.io/dockerconfigjson"
}
