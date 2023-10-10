variable "alb_grafana_release_name" {
  description = "Name of the Helm release for the Spring PetClinic API Gateway service"
}

variable "alb_grafana_chart_path" {
  description = "Path to the Helm chart for the Spring PetClinic API Gateway service"
}

variable "alb_grafana_chart_version" {
  description = "Version of the Helm chart to use for deploying the Spring PetClinic API Gateway service"
}

variable "alb_grafana_values_file" {
  description = "Path to the Helm values.yaml file for the Spring PetClinic API Gateway service"
}

variable "alb_grafana_alb_name" {
  description = "Name of the Application Load Balancer"
}

variable "alb_grafana_certificateArn" {
  description = "ARN of the ACM certificate"
}

variable "alb_grafana_domain_name" {
  description = "The domain name for Route53."
  type        = string
}

variable "alb_grafana_record_name" {
  description = "The DNS record name."
  type        = string
}

variable "alb_grafana_cleaned_domain_name" {
  description = "The DNS record name."
  type        = string
}