## otc-prometheus-exporter

This module deploys our [otc-prometheus-exporter](https://github.com/iits-consulting/otc-prometheus-exporter) with wich metrics on the open telekom cloud can be monitored

Example:
```HCL
module "otc_prometheus_exporter" {
  source      = "registry.terraform.io/iits-consulting/project-factory/opentelekomcloud//modules/otc-prometheus-exporter"
  name_prefix = "${var.context}-${var.stage}"
  domain_name = var.otc_domain_name
}
```
