resource "aws_acm_certificate" "cert" {
  domain_name       = replace(var.domain_name, "_", "-")
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.acm_dns_validation[var.domain_name].fqdn]
}
