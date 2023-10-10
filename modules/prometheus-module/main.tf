resource "null_resource" "helm_repos" {
  provisioner "local-exec" {
    command = <<EOT
      helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
      helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
      helm repo update
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

# Création du namespace pour Prometheus
resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = "prometheus"
  }
}

# Installation de Prometheus via Helm
resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = kubernetes_namespace.prometheus.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"

  set {
    name  = "alertmanager.persistentVolume.storageClass"
    value = "gp2"
  }

  set {
    name  = "server.persistentVolume.storageClass"
    value = "gp2"
  }
}