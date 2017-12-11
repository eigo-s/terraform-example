# Create a new Datadog user
resource "datadog_user" "admin" {
  count = "${length(var.datadog_admin_name)}"

  name   = "${element(var.datadog_admin_name, count.index)}"
  email  = "${element(var.datadog_admin_email, count.index)}"
  handle = "${element(var.datadog_admin_email, count.index)}"

  role = "admin"
  is_admin = true
}

resource "datadog_user" "standard" {
  count = "${length(var.datadog_standard_name)}"

  name   = "${element(var.datadog_standard_name, count.index)}"
  email  = "${element(var.datadog_standard_email, count.index)}"
  handle = "${element(var.datadog_standard_email, count.index)}"

  is_admin = false
}
