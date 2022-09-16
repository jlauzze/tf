resource "aws_route53_record" "base_nlb_cname" {
  zone_id = var.private_zone_id
  name    = "${var.name}-nlb"
  type    = "CNAME"
  ttl     = 60
  records = [aws_lb.nlb.dns_name]
}
