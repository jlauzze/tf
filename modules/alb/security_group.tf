resource "aws_security_group" "sg" {
  name        = "${var.name}-alb-sg"
  description = "${var.name} alb sg"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress_secgroup" {
  count                    = length(var.security_groups)
  type                     = "ingress"
  from_port                = var.secure_port != null ? var.secure_port : var.insecure_port
  to_port                  = var.secure_port != null ? var.secure_port : var.insecure_port
  protocol                 = "tcp"
  source_security_group_id = var.security_groups[count.index]
  security_group_id        = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ingress_cidr" {
  count             = length(var.cidr_blocks)
  type              = "ingress"
  from_port         = var.secure_port != null ? var.secure_port : var.insecure_port
  to_port           = var.secure_port != null ? var.secure_port : var.insecure_port
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks[count.index]]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "egress_secgroup" {
  count                    = length(var.security_groups)
  type                     = "egress"
  from_port                = var.secure_port != null ? var.secure_port : var.insecure_port
  to_port                  = var.secure_port != null ? var.secure_port : var.insecure_port
  protocol                 = "tcp"
  source_security_group_id = var.security_groups[count.index]
  security_group_id        = aws_security_group.sg.id
}

resource "aws_security_group_rule" "egress_cidr" {
  count             = length(var.cidr_blocks)
  type              = "egress"
  from_port         = var.secure_port != null ? var.secure_port : var.insecure_port
  to_port           = var.secure_port != null ? var.secure_port : var.insecure_port
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_blocks[count.index]]
  security_group_id = aws_security_group.sg.id
}
