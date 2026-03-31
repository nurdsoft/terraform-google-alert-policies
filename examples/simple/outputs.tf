output "alert_policy_ids" {
  description = "Map of alert policy keys to their GCP resource IDs."
  value       = module.alert_policies.alert_policy_ids
}

output "alert_policy_names" {
  description = "Map of alert policy keys to their GCP resource names."
  value       = module.alert_policies.alert_policy_names
}
