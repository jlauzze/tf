locals {
  # this is hard to read, this is the logic in pseudocode
  # if defined(var.backend_port_override) {
  #   backend_port = var.backend_port_override
  # } else if defined(var.secure_port) {
  #   backend_port = var.secure_port
  # } else {
  #   backend_port = var.insecure_port
  # }
  backend_port = var.backend_port_override != null ? var.backend_port_override : (var.secure_port != null ? var.secure_port : var.insecure_port)
  name         = replace(var.name, "_", "-")
}

resource "aws_alb" "alb" {
  name            = local.name
  internal        = var.internal
  security_groups = concat(var.security_groups, [aws_security_group.sg.id])
  subnets         = var.subnets
  idle_timeout    = var.idle_timeout
  access_logs {
    bucket  = "pw-${local.name}-${var.environment}-access-logs"
    enabled = true
  }
}

resource "aws_alb_listener" "http" {
  count             = var.insecure_port != null ? 1 : 0
  load_balancer_arn = aws_alb.alb.arn
  port              = var.insecure_port != null ? var.insecure_port : 80

  default_action {
    target_group_arn = aws_alb_target_group.alb.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  count        = (var.insecure_port != null && var.secure_port != null) ? 1 : 0
  listener_arn = aws_alb_listener.http.0.arn

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_alb_listener" "https" {
  count             = var.secure_port != null ? 1 : 0
  load_balancer_arn = aws_alb.alb.arn
  port              = var.secure_port != null ? var.secure_port : 443
  protocol          = "HTTPS"
  certificate_arn   = var.ssl_arn != "" ? var.ssl_arn : module.acm.arn

  default_action {
    target_group_arn = aws_alb_target_group.alb.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_certificate" "additional_certificates" {
  count           = var.secure_port != null ? length(var.additional_certificates) : 0
  listener_arn    = aws_alb_listener.https.0.arn
  certificate_arn = var.additional_certificates[count.index]
}

resource "aws_alb_target_group" "alb" {
  name                 = local.name
  port                 = local.backend_port == -1 ? var.secure_port : local.backend_port
  protocol             = var.backend_protocol
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay

  health_check {
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    protocol            = var.health_check_protocol
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    matcher             = var.target_group_matcher
    port                = var.health_check_port
    path                = var.health_check_path
  }

  # something is wrong with this, specifically terraform reports that an NLB doesn't support stickiness, but we're not using a NLB.
  # stickiness {
  #   type    = var.stickiness
  #   enabled = var.stickiness == "lb_cookie" ? true : false
  # }
}
