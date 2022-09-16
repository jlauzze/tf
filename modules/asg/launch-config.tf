resource "aws_launch_configuration" "lc" {
  name_prefix                 = "${var.name}-"
  image_id                    = "ami-0c2ab3b8efb09f272"
  instance_type               = var.instance_type
  user_data                   = data.template_cloudinit_config.config.rendered
  key_name                    = "joe_free_account"
  associate_public_ip_address = var.public_ip
  iam_instance_profile        = var.iam_instance_profile
  security_groups             = var.security_groups

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    encrypted   = true
  }

  dynamic "ebs_block_device" {
    for_each = var.additional_volumes

    content {
      device_name           = lookup(ebs_block_device.value, "device_name", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [image_id]
  }
}
