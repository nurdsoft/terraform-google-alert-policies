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

resource "google_monitoring_alert_policy" "additional" {
  for_each = var.additional_alert_policies

  project      = each.value.project
  display_name = each.value.display_name
  combiner     = "OR"
  severity     = each.value.severity

  conditions {
    display_name = each.value.condition_name

    condition_threshold {
      filter          = each.value.filter
      comparison      = each.value.comparison
      threshold_value = each.value.threshold_value
      duration        = each.value.duration

      aggregations {
        alignment_period     = "60s"
        per_series_aligner   = each.value.aligner
        cross_series_reducer = each.value.reducer
        group_by_fields      = each.value.group_by_fields
      }

      dynamic "trigger" {
        for_each = each.value.trigger_count == null ? [] : [1]
        content {
          count = each.value.trigger_count
        }
      }
    }
  }

  notification_channels = var.notification_channels

  dynamic "documentation" {
    for_each = each.value.documentation == null ? [] : [each.value.documentation]
    content {
      content   = documentation.value.content
      mime_type = documentation.value.mime_type
    }
  }

  user_labels = each.value.user_labels
}
