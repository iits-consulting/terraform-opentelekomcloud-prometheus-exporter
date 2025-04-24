variable "name_prefix" {
  type        = string
  description = "Prefix of the OTC ressources created."
}

variable "release_name" {
  default     = "otc-prometheus-exporter"
  type        = string
  description = "Name ot the release namespace."
}

variable "release_namespace" {
  type        = string
  default     = "monitoring"
  description = "Kubernetes namespace to install the chart to."
}

variable "domain_name" {
  type        = string
  description = "Domain name of the OTC"
}

variable "chart_repository" {
  type        = string
  default     = "https://iits-consulting.github.io/otc-prometheus-exporter/"
  description = "Chart repository of the IITS otc-prometheus-exporter chart."
}

variable "chart_name" {
  type        = string
  default     = "otc-prometheus-exporter"
  description = "Name of the IITS otc-prometheus-exporter chart."
}

variable "chart_version" {
  type        = string
  default     = "1.2.9"
  description = "Chart version of the IITS otc-prometheus-exporter chart."
}

variable "chart_values" {
  type        = list(string)
  default     = []
  description = "Override the values of the IITS otc-prometheus-exporter chart using value files."
}

variable "chart_set_parameter" {
  type = list(object({
    name  = string
    value = optional(string)
    type  = optional(string)
  }))
  default     = []
  description = "Override the values of the IITS otc-prometheus-exporter chart using set."
}

variable "chart_set_list_parameter" {
  type = list(object({
    name  = string
    value = list(string)
  }))
  default     = []
  description = "Override the values of the IITS otc-prometheus-exporter chart using set_list."
}

variable "chart_set_sensitive_parameter" {
  type = list(object({
    name  = string
    value = string
    type  = optional(string)
  }))
  default     = []
  description = "Override the values of the IITS otc-prometheus-exporter chart using set_sensitive."
}
