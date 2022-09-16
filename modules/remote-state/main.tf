resource "aws_s3_bucket" "remote_state" {
  bucket = "${var.profile}-terraform-common-terraform-state"
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = "true"
  }

  lifecycle_rule {
    id      = "noncurrent_version_reaper"
    prefix  = ""
    enabled = true
    noncurrent_version_expiration {
      days = 7
    }
  }

  tags = {
    Name       = "${var.profile}-terraform-common-terraform-state"
    automation = var.automation
    owner      = "Cloud Ops"
    repo_name  = var.repo_name
    repo_path  = "${var.profile}/remote-state"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.remote_state.id

  # Block new public ACLs and uploading public objects
  block_public_acls = true

  # Retroactively remove public access granted through public ACLs
  ignore_public_acls = true

  # Block new public bucket policies
  block_public_policy = true

  # Retroactivley block public and cross-account access if bucket has public policies
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "statelock" {
  name         = "terraform-statelock"
  billing_mode = "PROVISIONED"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  read_capacity  = 5
  write_capacity = 5

  tags = {
    Name       = "terraform-statelock"
    automation = var.automation
    owner      = "Cloud Ops"
    repo_name  = var.repo_name
    repo_path  = "${var.profile}/remote-state"
  }
}
