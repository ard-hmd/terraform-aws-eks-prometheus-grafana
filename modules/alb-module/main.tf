# Retrieve the existing VPC with the specified tags
data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Retrieve public subnets in Availability Zone A
data "aws_subnet" "public_subnets_a" {
  vpc_id = data.aws_vpc.existing_vpc.id
  tags = {
    Name = var.az_a_subnet_name
  }
}

# Retrieve public subnets in Availability Zone B
data "aws_subnet" "public_subnets_b" {
  vpc_id = data.aws_vpc.existing_vpc.id
  tags = {
    Name = var.az_b_subnet_name
  }
}

# Local Variables
# These local variables store computed values.

locals {
  all_public_subnets = [data.aws_subnet.public_subnets_a.id, data.aws_subnet.public_subnets_b.id]
}

resource "helm_release" "alb_grafana" {
  name      = "${var.alb_grafana_release_name}"
  namespace = "grafana"
  chart     = var.alb_grafana_chart_path
  version   = var.alb_grafana_chart_version

  set {
    name  = "namespace"
    value = "grafana"
  }
  
  set {
    name  = "alb.tags"
    value = "Name=${var.alb_grafana_alb_name}"
  }

  set {
    name  = "ingress.host"
    value = "${var.alb_grafana_fqdn}"
  }

  set {
    name  = "ingress.certificateArn"
    value = var.alb_grafana_certificateArn
  }

  set {
    name  = "ingress.subnets"
    value = join("\\,", local.all_public_subnets)
  }

  values = [file(var.alb_grafana_values_file)]

}