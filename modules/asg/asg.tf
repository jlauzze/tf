resource "aws_autoscaling_group" "asg" {
  name                      = "${var.name} autoscaling group"
  vpc_zone_identifier       = var.subnets
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  force_delete              = false
  launch_configuration      = aws_launch_configuration.lc.name
  target_group_arns         = var.target_group_arns != [] ? var.target_group_arns : null
  load_balancers            = var.load_balancers != [] ? var.load_balancers : null
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  wait_for_capacity_timeout = "5m"
  default_cooldown          = var.scaling_cooldown
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  suspended_processes = var.suspended_processes

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      desired_capacity,
      target_group_arns
    ]
  }

  tag {
    key                 = "Name"
    value               = "${var.name} ASG"
    propagate_at_launch = true
  }
}
