variable "notification_channels" {
  description = <<-EOT
    Identifies the notification channels to which notifications should be sent when incidents are opened or closed or when new violations occur on an already opened incident. Each element of this array corresponds to the name field in each of the NotificationChannel objects that are returned from the notificationChannels.list method. The syntax of the entries in this field is projects/[PROJECT_ID]/notificationChannels/[CHANNEL_ID]
  EOT
  type        = list(string)
}

variable "alert_services_regex" {
  description = "Regex used to match Cloud Run service names. Unused when enable_built_in_policies is false."
  type        = string
  default     = ""
}

# ---------------------------------------------------------------------------
# Alert Policy 1 – Cloud Run High Traffic
# ---------------------------------------------------------------------------

variable "high_request_alert_display_name" {
  description = "Display name for Cloud Run high traffic alert. Unused when enable_built_in_policies is false."
  type        = string
  default     = ""
}

variable "high_request_threshold" {
  description = "Request rate threshold."
  type        = number
  default     = 10
}

variable "high_request_duration" {
  description = "Duration for high request threshold."
  type        = string
  default     = "60s"
}


# ---------------------------------------------------------------------------
# Alert Policy 2 – Cloud Run Error Logs
# ---------------------------------------------------------------------------

variable "error_alert_display_name" {
  description = "Display name for Cloud Run error alert. Unused when enable_built_in_policies is false."
  type        = string
  default     = ""
}

variable "error_threshold" {
  description = "Error count threshold."
  type        = number
  default     = 1
}

variable "error_duration" {
  description = "Duration for error threshold."
  type        = string
  default     = "0s"
}

# ---------------------------------------------------------------------------
# Alert Policy 3 – Cloud SQL CPU Utilization
# ---------------------------------------------------------------------------

variable "cpu_alert_display_name" {
  description = "Display name for Cloud SQL CPU alert. Unused when enable_built_in_policies is false."
  type        = string
  default     = ""
}

variable "cpu_threshold" {
  description = "CPU utilization threshold."
  type        = number
  default     = 0.75
}

variable "cpu_duration" {
  description = "Duration for CPU threshold."
  type        = string
  default     = "0s"
}

# ---------------------------------------------------------------------------
# Alert Policy 4 – Cloud SQL Disk Utilization
# ---------------------------------------------------------------------------

variable "disk_alert_display_name" {
  description = "Display name for Cloud SQL disk alert. Unused when enable_built_in_policies is false."
  type        = string
  default     = ""
}

variable "disk_threshold" {
  description = "Disk utilization threshold."
  type        = number
  default     = 0.50
}

variable "disk_duration" {
  description = "Duration for disk threshold."
  type        = string
  default     = "0s"
}

# ---------------------------------------------------------------------------
# Built-in policy toggle
# ---------------------------------------------------------------------------

variable "enable_built_in_policies" {
  description = <<-EOT
    Whether to create the four built-in Cloud Run + Cloud SQL alert policies.
    Defaults to true (existing behavior). Set to false when the module is used
    purely to provision policies via additional_alert_policies (e.g. from a
    frontend edge module) — the six built-in display_name / regex inputs become
    unused but are still validated as non-empty strings, so pass placeholder
    strings if you must.
  EOT
  type        = bool
  default     = true
}

# ---------------------------------------------------------------------------
# Additional alert policies (opt-in)
# ---------------------------------------------------------------------------

variable "additional_alert_policies" {
  description = <<-EOT
    Additional alert policies keyed by unique name. Each entry becomes its own
    google_monitoring_alert_policy instance. Keys must not collide with the
    built-in keys: cloud_run_high_traffic, cloud_run_error_alert,
    cloud_sql_cpu_alert, cloud_sql_disk_alert.
  EOT
  type = map(object({
    display_name    = string
    condition_name  = string
    severity        = string
    filter          = string
    threshold_value = number
    duration        = string

    aligner         = optional(string)
    comparison      = optional(string, "COMPARISON_GT")
    reducer         = optional(string)
    group_by_fields = optional(list(string), [])
    trigger_count   = optional(number)
    project         = optional(string)
    user_labels     = optional(map(string))

    documentation = optional(object({
      content   = string
      mime_type = optional(string, "text/markdown")
    }))
  }))
  default = {}

  validation {
    condition     = length(setintersection(keys(var.additional_alert_policies), ["cloud_run_high_traffic", "cloud_run_error_alert", "cloud_sql_cpu_alert", "cloud_sql_disk_alert"])) == 0
    error_message = "additional_alert_policies keys must not collide with built-in policy keys."
  }
}
