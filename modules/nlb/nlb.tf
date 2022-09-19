resource "aws_lb" "nlb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.subnets
}

resource "aws_lb_listener" "nlb" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    target_group_arn = aws_lb_target_group.nlb.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "nlb" {
  name        = var.name
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type
  health_check {
    interval            = var.interval
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    protocol            = var.protocol
    port                = var.port
  }
}
