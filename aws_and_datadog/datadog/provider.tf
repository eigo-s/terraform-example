terraform {
  required_version = "~> 0.11.0"
}

provider "datadog" {
  version = "~> 1.0.1"

  api_key = "${var.datadog_api_key}"
  app_key = "${var.datadog_app_key}"
}
