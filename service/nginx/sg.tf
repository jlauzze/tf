resource "aws_security_group" "demo" {
  name   = var.name
  vpc_id = module.vpc.vpc_id

  ingress {
    description = ""
    from_port   = 0
    to_port     = 65535
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