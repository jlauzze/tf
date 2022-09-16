data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  # this logic dynamically generates "parts" to send to the data resource.
  # In the event one of these values isn't passed to the module, the part wont be generated
  # this lets us send cloud-init files AND/OR userdata files dynamically
  # Main cloud-config configuration file.
  dynamic "part" {
    for_each = var.cloud-init != null ? ["1"] : []
    content {
      filename     = var.cloud-init != null ? "init.cfg" : null
      content_type = var.cloud-init != null ? "text/cloud-config" : null
      content      = var.cloud-init
    }
  }

  # userdata
  dynamic "part" {
    for_each = var.user-data != null ? ["1"] : []
    content {
      content_type = var.user-data != null ? "text/x-shellscript" : null
      content      = var.user-data
    }
  }
}
