resource "aws_route53_record" "base_nlb_cname" {
  zone_id = var.public_zone_id
  name    = "${var.name}"
  type    = "CNAME"
  ttl     = 60
  records = [aws_lb.nlb.dns_name]
}
