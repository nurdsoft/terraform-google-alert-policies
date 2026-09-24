output "additional_alert_policy_ids" {
  description = "IDs of the frontend alert policies."
  value       = module.alert_policies.additional_alert_policy_ids
}

output "additional_alert_policy_names" {
  description = "Resource names of the frontend alert policies."
  value       = module.alert_policies.additional_alert_policy_names
}
