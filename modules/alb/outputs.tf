output "name" {
  value = aws_alb.alb.name
}

output "id" {
  value = aws_alb.alb.id
}

output "target_group_arn" {
  value = aws_alb_target_group.alb.arn
}

output "dns_name" {
  value = aws_alb.alb.dns_name
}

output "alb_arn" {
  value = aws_alb.alb.arn
}

output "ssl_arn" {
  value = module.acm.arn
}

output "sec_group_id" {
  value = aws_security_group.sg.id
}
