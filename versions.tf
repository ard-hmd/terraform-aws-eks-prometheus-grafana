# Terraform Provider Configuration
# This section defines the required Terraform providers and their versions.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}
