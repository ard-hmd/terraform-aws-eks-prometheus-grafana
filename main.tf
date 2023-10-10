module "grafana_module" {
  source = "./modules/grafana-module"
}

module "prometheus_module" {
  source = "./modules/prometheus-module"
}

module "alb_module" {
  source = "./modules/alb-module"

  vpc_name                   = var.vpc_name
  az_a_subnet_name           = var.az_a_subnet_name
  az_b_subnet_name           = var.az_b_subnet_name
  alb_grafana_release_name   = var.alb_grafana_release_name
  alb_grafana_chart_path     = var.alb_grafana_chart_path
  alb_grafana_chart_version  = var.alb_grafana_chart_version
  alb_grafana_values_file    = var.alb_grafana_values_file
  alb_grafana_alb_name       = var.alb_grafana_alb_name
  alb_grafana_fqdn           = "${var.alb_grafana_record_name}.${var.alb_grafana_cleaned_domain_name}"
  alb_grafana_certificateArn = var.alb_grafana_certificateArn

  depends_on = [module.grafana_module]
}

# Null resource for introducing sleep (useful for waiting)
resource "null_resource" "sleep" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "sleep 120"
  }
  depends_on = [module.alb_module]
}

module "route53_module" {
  source = "./modules/route53-module"

  alb_grafana_alb_name    = var.alb_grafana_alb_name
  alb_grafana_record_name = var.alb_grafana_record_name
  alb_grafana_domain_name = var.alb_grafana_domain_name

  depends_on = [module.alb_module]
}