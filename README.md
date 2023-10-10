# Terraform AWS EKS Prometheus & Grafana Deployment

## Introduction

This repository provides a Terraform solution to deploy a monitoring stack on AWS EKS, including Prometheus and Grafana, with an associated ALB and Route53 DNS record.

## Key Features

- Automated deployment of Prometheus and Grafana on AWS EKS.
- ALB creation with associated Route53 DNS record.
- Modular design for easy customization and scalability.

## Initial Setup

1. Ensure you have an operational EKS cluster with at least 2 Availability Zones.
2. Ensure you have an AWS Certificate Manager (ACM) certificate available for use.
3. Ensure you possess a domain name and have a corresponding Route53 hosted zone set up in AWS.
4. Ensure you have the AWS ALB Ingress Controller installed in your EKS cluster.
5. Ensure you have Terraform and kubectl installed.
6. Clone this repository.
7. Set up your AWS credentials or ensure your environment can access AWS.
8. Configure your variables in the `terraform.tfvars` file.

## Configuration Variables

### Main Repo:

- `kube_config_path`: Path to your Kubernetes configuration file.
- `aws_region`: AWS region where resources will be deployed.
- `vpc_name`: Name of the VPC.
- `az_a_subnet_name`: Name of the subnet in Availability Zone A.
- `az_b_subnet_name`: Name of the subnet in Availability Zone B.

### Module `alb_module`:

- `alb_grafana_release_name`: Name of the Helm release for Grafana ALB.
- `alb_grafana_chart_path`: Path to the Helm chart for Grafana ALB.
- `alb_grafana_chart_version`: Version of the Helm chart for Grafana ALB.
- `alb_grafana_values_file`: Path to the values file for the Helm chart.
- `alb_grafana_alb_name`: Name of the ALB for Grafana.
- `alb_grafana_fqdn`: Fully qualified domain name for Grafana ALB.
- `alb_grafana_certificateArn`: ARN of the ACM certificate for Grafana ALB.

### Module `route53_module`:

- `alb_grafana_domain_name`: Domain name for the ALB.
- `alb_grafana_cleaned_domain_name`: Cleaned domain name for the ALB.
- `alb_grafana_record_name`: Record name for the ALB in Route53.

## Example terraform.tfvars file:

```
kube_config_path                = "/path/to/kubeconfig"
aws_region                      = "us-west-1"
vpc_name                        = "example-vpc"
az_a_subnet_name                = "example-subnet-a"
az_b_subnet_name                = "example-subnet-b"
alb_grafana_release_name        = "example-release-name"
alb_grafana_chart_path          = "/path/to/helm-chart"
alb_grafana_chart_version       = "1.0.0"
alb_grafana_values_file         = "/path/to/values.yaml"
alb_grafana_alb_name            = "example-alb-name"
alb_grafana_certificateArn      = "arn:aws:acm:example-region:123456789012:certificate/example-certificate-id"
alb_grafana_domain_name         = "example.com."
alb_grafana_cleaned_domain_name = "example.com"
alb_grafana_record_name         = "example-record"
```

## Deployment

1. Configure your `terraform.tfvars` file with appropriate values.
2. Run `terraform plan` to review the changes that will be made.
3. Apply the changes with `terraform apply`.

## Destruction

To destroy the deployed resources, simply run `terraform destroy`.
