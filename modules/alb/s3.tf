module "s3" {
  source      = "/terraform/modules/s3_access_log"
  bucket_name = "pw-${local.name}-${var.environment}-access-logs"
  policy      = <<-EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "AWS": "arn:aws:iam::${var.load_balancing_account_ids[var.region]}:root"
        },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::pw-${local.name}-${var.environment}-access-logs/*"
        }
    ]
    }
EOF
}
