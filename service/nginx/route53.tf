resource "aws_route53_zone" "demo_zone" {
  name = var.dns_suffix

  tags = {
    Environment = "dev"
  }
}