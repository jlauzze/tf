data "aws_vpc" "demo" {
  filter {
    name   = "tag:Name"
    values = ["default-staging-vpc"]
  }
}

data "aws_subnet_ids" "demo_public" {
  vpc_id = data.aws_vpc.demo.id
  filter {
    name   = "tag:Name"
    values = ["default-staging-vpc-public-*"]
  }
  depends_on = [module.vpc]
}

data "aws_route53_zone" "lauzze" {
  name         = "lauzze.link"
  private_zone = false
}
