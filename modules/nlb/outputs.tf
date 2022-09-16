output "name" {
  value = aws_lb.nlb.name
}

output "id" {
  value = aws_lb.nlb.id
}

output "target_group_arn" {
  value = aws_lb_target_group.nlb.arn
}

output "dns_name" {
  value = aws_lb.nlb.dns_name
}

output "nlb_arn" {
  value = aws_lb.nlb.arn
}
