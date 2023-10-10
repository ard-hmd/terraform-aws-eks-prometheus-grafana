resource "null_resource" "helm_repos" {
  provisioner "local-exec" {
    command = <<EOT
      helm repo add grafana https://grafana.github.io/helm-charts
      helm repo update
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

# Création du namespace pour Grafana
resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "grafana"
  }
}

# Installation de Grafana via Helm
resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = kubernetes_namespace.grafana.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"

  set {
    name  = "persistence.storageClass"
    value = "gp2"
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "adminPassword"
    value = "password"
  }

  set {
    name  = "service.type"
    value = "NodePort"
  }

  values = [file("${path.module}/grafana.yaml")]
}

