output "alert_policy_ids" {
  description = "Map of alert policy keys to their GCP resource IDs."
  value       = { for k, v in google_monitoring_alert_policy.this : k => v.id }
}

output "alert_policy_names" {
  description = "Map of alert policy keys to their GCP resource names."
  value       = { for k, v in google_monitoring_alert_policy.this : k => v.name }
}
