locals {
  alert_policies = {
    cloud_run_high_traffic = {
      display_name    = var.high_request_alert_display_name
      condition_name  = "Cloud Run - Request Rate"
      severity        = "WARNING"
      filter          = "resource.type=\"cloud_run_revision\" AND metric.type=\"run.googleapis.com/request_count\" AND resource.labels.service_name=monitoring.regex.full_match(\"${var.alert_services_regex}\")"
      threshold_value = var.high_request_threshold
      duration        = var.high_request_duration
      aligner         = "ALIGN_RATE"
      reducer         = null
      group_by_fields = []
    }

    cloud_run_error_alert = {
      display_name    = var.error_alert_display_name
      condition_name  = "Cloud Run - Error Logs"
      severity        = "ERROR"
      filter          = "resource.type=\"logging_bucket\" AND metric.type=\"logging.googleapis.com/user/ago_services_error_count\""
      threshold_value = var.error_threshold
      duration        = var.error_duration
      aligner         = "ALIGN_COUNT"
      reducer         = "REDUCE_SUM"
      group_by_fields = ["metric.label.service_name"]
    }

    cloud_sql_cpu_alert = {
      display_name    = var.cpu_alert_display_name
      condition_name  = "Cloud SQL Database - CPU utilization"
      severity        = "WARNING"
      filter          = "resource.type=\"cloudsql_database\" AND metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\""
      threshold_value = var.cpu_threshold
      duration        = var.cpu_duration
      aligner         = "ALIGN_MEAN"
      reducer         = null
      group_by_fields = ["resource.labels.database_id"]
    }

    cloud_sql_disk_alert = {
      display_name    = var.disk_alert_display_name
      condition_name  = "Disk utilization > 50%"
      severity        = "WARNING"
      filter          = "resource.type=\"cloudsql_database\" AND metric.type=\"cloudsql.googleapis.com/database/disk/utilization\""
      threshold_value = var.disk_threshold
      duration        = var.disk_duration
      aligner         = "ALIGN_MEAN"
      reducer         = null
      group_by_fields = ["resource.labels.database_id"]
    }
  }
}
