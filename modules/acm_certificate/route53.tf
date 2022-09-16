resource "aws_route53_record" "acm_dns_validation" {
  zone_id = var.public_zone_id
  for_each = {
    for each in aws_acm_certificate.cert.domain_validation_options : each.domain_name => {
      name    = each.resource_record_name
      type    = each.resource_record_type
      ttl     = "60"
      records = [each.resource_record_value]
    }
  }

  name    = each.value.name
  records = each.value.records
  ttl     = each.value.ttl
  type    = each.value.type

}
