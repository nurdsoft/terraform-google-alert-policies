variable "project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
}

variable "notification_channels" {
  description = <<-EOT
    Identifies the notification channels to which notifications should be sent when incidents are opened or closed or when new violations occur on an already opened incident. Each element of this array corresponds to the name field in each of the NotificationChannel objects that are returned from the notificationChannels.list method. The syntax of the entries in this field is projects/[PROJECT_ID]/notificationChannels/[CHANNEL_ID]
  EOT
  type        = list(string)
}

variable "alert_services_regex" {
  description = "Regex pattern used to match Cloud Run service names (e.g. \"service-a|service-b\")."
  type        = string
}

# ------------------------------------------------------------------------------
# Optional Overrides — all have sensible defaults in the module
# ------------------------------------------------------------------------------

variable "high_request_alert_display_name" {
  description = "Display name for the Cloud Run high request rate alert policy."
  type        = string
  default     = "Cloud Run - High Request Rate Alert"
}

variable "error_alert_display_name" {
  description = "Display name for the Cloud Run error log spike alert policy."
  type        = string
  default     = "Cloud Run - Error Log Spike Alert"
}

variable "cpu_alert_display_name" {
  description = "Display name for the Cloud SQL CPU utilization alert policy."
  type        = string
  default     = "Cloud SQL - High CPU Utilization Alert"
}

variable "disk_alert_display_name" {
  description = "Display name for the Cloud SQL disk utilization alert policy."
  type        = string
  default     = "Cloud SQL - High Disk Utilization Alert"
}

variable "high_request_threshold" {
  description = "Request rate threshold in requests per second."
  type        = number
  default     = 10
}

variable "error_threshold" {
  description = "Number of ERROR log entries that must be exceeded before the alert fires."
  type        = number
  default     = 1
}

variable "cpu_threshold" {
  description = "CPU utilization threshold as a decimal fraction (0.0–1.0). Default is 0.75 (75%)."
  type        = number
  default     = 0.75
}

variable "disk_threshold" {
  description = "Disk utilization threshold as a decimal fraction (0.0–1.0). Default is 0.50 (50%)."
  type        = number
  default     = 0.50
}
