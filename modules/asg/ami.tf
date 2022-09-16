data "aws_ami" "ami" {
  most_recent = true
  owners      = var.ami_owners

  dynamic "filter" {
    for_each = var.ami_filters
    content {
      name   = filter.key
      values = [filter.value]
    }
  }
}

