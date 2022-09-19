module "nlb" {
  source          = "../../modules/nlb"
  name            = var.name
  vpc_id          = data.aws_vpc.demo.id
  private_zone_id = null
  public_zone_id  = aws_route53_zone.demo_zone.id
  subnets         = data.aws_subnet_ids.demo_public.ids
  internal        = true
  port            = 8080
}