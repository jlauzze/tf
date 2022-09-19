resource "aws_route53_record" "base_alb_cname" {
  zone_id = var.public_zone_id
  name    = local.name
  type    = "CNAME"
  ttl     = 60
  records = [aws_alb.alb.dns_name]
}
