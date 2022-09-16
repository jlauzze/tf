module "acm" {
  source = "../../modules/acm_certificate"

  domain_name    = var.name
  public_zone_id = aws_route53_zone.demo_zone.id

  depends_on = [aws_route53_zone.demo_zone]
}
