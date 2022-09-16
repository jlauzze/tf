module "nlb" {
  source          = "../../modules/nlb"
  name            = var.name
  vpc_id          = data.aws_vpc.demo.id
  private_zone_id = null
  public_zone_id  = aws_route53_zone.demo_zone.id
  subnets         = var.subnets
  internal        = true
  port            = 443
}

resource "aws_lb_target_group" "https" {
  name        = "${var.name}-nlb-https"
  port        = 8080
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.demo.id
  target_type = "instance"
  health_check {
    interval            = 30
    healthy_threshold   = 10
    unhealthy_threshold = 10
    protocol            = "HTTP"
    path                = "/"
  }
}

resource "aws_autoscaling_attachment" "https" {
  autoscaling_group_name = module.asg.id
  lb_target_group_arn    = aws_lb_target_group.https.arn
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = module.nlb.nlb_arn
  port              = 443
  protocol          = "TLS"
  certificate_arn   = module.acm.arn

  default_action {
    target_group_arn = aws_lb_target_group.https.arn
    type             = "forward"
  }
}