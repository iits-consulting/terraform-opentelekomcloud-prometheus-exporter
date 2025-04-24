resource "helm_release" "otc-prometheus-exporter" {
  name                  = var.release_name
  chart                 = var.chart_name
  repository            = var.chart_repository
  version               = var.chart_version
  namespace             = var.release_namespace
  create_namespace      = true
  wait                  = true
  atomic                = true
  timeout               = 900 // 15 Minutes
  render_subchart_notes = true
  dependency_update     = true
  wait_for_jobs         = true
  values = concat([
    yamlencode({
      serviceMonitor = {
        labels = {
          release = "kube-prom-stack"
        }
      }
  })], var.chart_values)

  dynamic "set" {
    for_each = { for param in var.chart_set_parameter : param.name => {
      value = param.value
      type  = param.type
    } }
    content {
      name  = set.key
      value = set.value.value
      type  = set.value.type
    }
  }

  dynamic "set_list" {
    for_each = { for param in var.chart_set_list_parameter : param.name => param.value }
    content {
      name  = set_list.key
      value = set_list.value
    }
  }

  dynamic "set_sensitive" {
    for_each = {
      "deployment.env.OS_ACCESS_KEY"  = opentelekomcloud_identity_credential_v3.user_aksk.access
      "deployment.env.OS_SECRET_KEY"  = opentelekomcloud_identity_credential_v3.user_aksk.secret
      "deployment.env.OS_PROJECT_ID"  = data.opentelekomcloud_identity_project_v3.current.id
      "deployment.env.OS_DOMAIN_NAME" = var.domain_name
    }
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  dynamic "set_sensitive" {
    for_each = { for param in var.chart_set_sensitive_parameter : param.name => {
      value = param.value
      type  = param.type
    } }
    content {
      name  = set_sensitive.key
      value = set_sensitive.value.value
      type  = set_sensitive.value.type
    }
  }
}
