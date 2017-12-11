variable "datadog_api_key" {}
variable "datadog_app_key" {}

variable "datadog_admin_name" {
  type = "list"
  default = [
    "admin"
  ]
}

variable "datadog_admin_email" {
  type = "list"
  default = [
    "new@example.com"
  ]
}

variable "datadog_standard_name" {
  type = "list"
  default = [
    "hoge"
  ]
}

variable "datadog_standard_email" {
  type = "list"
  default = [
    "hoge@example.com"
  ]
}

variable "datadog_monitor_slack_channel" {
  default = "slack-alert"
}

variable "datadog_monitor_cpu_usertime_thresholds_warning" {
  default = "50"
}
variable "datadog_monitor_cpu_usertime_thresholds_critical" {
  default = "60"
}
