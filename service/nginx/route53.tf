resource "aws_route53_zone" "demo_zone" {
  name = "joe.lauzze.com"

  tags = {
    Environment = "dev"
  }
}