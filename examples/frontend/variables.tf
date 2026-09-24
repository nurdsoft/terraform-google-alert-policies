variable "notification_channels" {
  description = "List of notification channel IDs to send alerts to."
  type        = list(string)
}

variable "project_id" {
  description = "GCP project ID for the alert policies."
  type        = string
}

variable "component" {
  description = "Component name used as a display-name prefix."
  type        = string
}

variable "url_map_name" {
  description = "URL map name matched in the 5xx alert filter."
  type        = string
}

variable "customer_domain" {
  description = "Customer domain used in the uptime-check alert filter."
  type        = string
}

variable "environment" {
  description = "Environment label (dev/prod) applied to user_labels."
  type        = string
}
