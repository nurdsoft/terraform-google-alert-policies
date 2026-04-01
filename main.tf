resource "google_monitoring_alert_policy" "this" {
  for_each = local.alert_policies

  display_name = each.value.display_name
  combiner     = "OR"
  severity     = each.value.severity

  conditions {
    display_name = each.value.condition_name

    condition_threshold {
      filter          = each.value.filter
      comparison      = "COMPARISON_GT"
      threshold_value = each.value.threshold_value
      duration        = each.value.duration

      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = each.value.aligner
        cross_series_reducer = each.value.reducer
        group_by_fields      = each.value.group_by_fields
      }
    }
  }

  notification_channels = var.notification_channels
}
