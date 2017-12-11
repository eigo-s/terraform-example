resource "datadog_monitor" "cpu_usertime" {
  name               = "CPU usertime usage high!! {{host.name}}"
  type               = "metric alert"
  message            = "{{#is_alert}} CPU usage high!! {{/is_alert}} @${var.datadog_monitor_slack_channel}"
  escalation_message = ""

  query = "avg(last_5m):avg:system.cpu.user{*} by {host} > ${var.datadog_monitor_cpu_usertime_thresholds_critical}"

  thresholds {
    warning  = "${var.datadog_monitor_cpu_usertime_thresholds_warning}"
    critical = "${var.datadog_monitor_cpu_usertime_thresholds_critical}"
  }

  notify_no_data    = false
  renotify_interval = 0

  notify_audit = false
  timeout_h    = 0
  include_tags = false

  tags = [
    "*",
  ]
}
