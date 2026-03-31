project_id            = "your-project-id"
notification_channels = ["projects/your-project-id/notificationChannels/12345"]
alert_services_regex  = "service-a|service-b|service-c"

high_request_alert_display_name = "Cloud Run - High Request Rate Alert"
error_alert_display_name        = "Cloud Run - Error Log Spike Alert"
cpu_alert_display_name          = "Cloud SQL - High CPU Utilization Alert"
disk_alert_display_name         = "Cloud SQL - High Disk Utilization Alert"

high_request_threshold = 10
error_threshold        = 1
cpu_threshold          = 0.75
disk_threshold         = 0.50
