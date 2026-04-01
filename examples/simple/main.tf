# -----------------------------------------------------------------------------
# Example: Alert Policies
#
# This example shows the minimal setup to use the alert-policies module.
# It assumes a GCP Monitoring notification channel already exists and
# passes its ID to the module.
# -----------------------------------------------------------------------------
module "alert_policies" {
  source = "git::https://github.com/nurdsoft/terraform-google-alert-policies.git?ref=v1.0.0"

  notification_channels = var.notification_channels
  alert_services_regex  = var.alert_services_regex

  high_request_alert_display_name = var.high_request_alert_display_name
  error_alert_display_name        = var.error_alert_display_name
  cpu_alert_display_name          = var.cpu_alert_display_name
  disk_alert_display_name         = var.disk_alert_display_name

  high_request_threshold = var.high_request_threshold
  error_threshold        = var.error_threshold
  cpu_threshold          = var.cpu_threshold
  disk_threshold         = var.disk_threshold
}
