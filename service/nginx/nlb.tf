module "nlb" {
  source          = "../../modules/nlb"
  name            = var.name
  vpc_id          = data.aws_vpc.demo.id
  private_zone_id = null
  public_zone_id  = data.aws_route53_zone.lauzze.id
  subnets         = data.aws_subnet_ids.demo_public.ids
  internal        = false
  port            = 8080
}