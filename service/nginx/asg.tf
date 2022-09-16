data "template_file" "user-data" {
  template = file("./templates/user-data.yaml")
  vars = {
    region      = var.region
    name        = var.name
    domain      = var.dns_suffix
    environment = var.environment
  }
}

module "asg" {
  source      = "../../modules/asg"
  name        = var.name
  environment = var.environment
  vpc_id      = data.aws_vpc.demo.id

  target_group_arns = [module.nlb.target_group_arn]

  user-data     = data.template_file.user-data.rendered
  instance_type = var.instance_size

  min_size         = var.group_size["min_size"]
  max_size         = var.group_size["max_size"]
  desired_capacity = var.group_size["desired_capacity"]
  scaling_cooldown = 600

  iam_instance_profile = module.demo_role.instance_profile_name

  public_ip       = true
  security_groups = [aws_security_group.demo.id]
  subnets         = data.aws_subnet_ids.demo_public.ids

  # this stops AWS from reclaiming an unhealthy node. This is disabled for zookeeper because it's a fragoh witto baby that doesn't know how to cluster.
  suspended_processes = [
    "Terminate"
  ]
}