module "acm" {
  source = "../acm_certificate"

  domain_name    = "${var.name}.${var.dns_suffix}"
  public_zone_id = var.public_zone_id
}
