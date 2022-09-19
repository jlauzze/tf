module "acm" {
  source = "../../modules/acm_certificate"

  domain_name    = "${var.name}.${var.dns_suffix}"
  public_zone_id = data.aws_route53_zone.lauzze.id
}
