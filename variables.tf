variable "notification_channels" {
  description = <<-EOT
    Identifies the notification channels to which notifications should be sent when incidents are opened or closed or when new violations occur on an already opened incident. Each element of this array corresponds to the name field in each of the NotificationChannel objects that are returned from the notificationChannels.list method. The syntax of the entries in this field is projects/[PROJECT_ID]/notificationChannels/[CHANNEL_ID]
  EOT
  type        = list(string)
}

variable "alert_services_regex" {
  description = "Regex used to match Cloud Run service names."
  type        = string
}

# ---------------------------------------------------------------------------
# Alert Policy 1 – Cloud Run High Traffic
# ---------------------------------------------------------------------------

variable "high_request_alert_display_name" {
  description = "Display name for Cloud Run high traffic alert."
  type        = string
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
  description = "Display name for Cloud Run error alert."
  type        = string
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
  description = "Display name for Cloud SQL CPU alert."
  type        = string
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
  description = "Display name for Cloud SQL disk alert."
  type        = string
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
