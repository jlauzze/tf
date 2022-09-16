resource "aws_security_group" "demo" {
  name   = var.name
  vpc_id = module.base_infrastructure_state.infrastructure_vpc_id

  ingress {
    description = ""
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      "174.16.254.121/32" #home public ipv4
    ]
  }


  egress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}