resource "aws_route53_record" "base_alb_cname" {
  zone_id = var.private_zone_id
  name    = "${local.name}-alb"
  type    = "CNAME"
  ttl     = 60
  records = [aws_alb.alb.dns_name]
}
