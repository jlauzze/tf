output "role_arn" {
  value = aws_iam_role.iam_role.arn
}

output "role_name" {
  value = aws_iam_role.iam_role.name
}

output "instance_profile_arn" {
  value = aws_iam_instance_profile.instance_profile.arn
}

output "instance_profile_id" {
  value = aws_iam_instance_profile.instance_profile.id
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.instance_profile.name
}
