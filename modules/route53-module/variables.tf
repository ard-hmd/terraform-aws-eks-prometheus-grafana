variable "alb_grafana_alb_name" {
  description = "Name of the Application Load Balancer"
}


variable "alb_grafana_domain_name" {
  description = "The domain name for Route53."
  type        = string
}

variable "alb_grafana_record_name" {
  description = "The DNS record name."
  type        = string
}

