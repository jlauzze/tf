module "demo_role" {
  source = "../../modules/iam_instance_profile_and_role"
  name   = "${var.name}-role"
  env    = var.environment
}

data "aws_iam_policy_document" "demo_policy_doc" {

  statement {
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "demo_policy" {
  name = "${var.name}-role-policy"
  role = module.demo_role.role_name

  policy = data.aws_iam_policy_document.demo_policy_doc.json
}