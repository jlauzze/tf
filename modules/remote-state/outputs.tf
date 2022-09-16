output "remote_state_s3" {
  value = aws_s3_bucket.remote_state.id
}

output "statelock_dynamo" {
  value = aws_dynamodb_table.statelock.id
}
