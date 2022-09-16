module "vpc" {
  source             = "../../modules/vpc"
  profile            = var.profile
  env                = "staging"
  department         = "devops"
  family             = "ivd"
  cidr               = "10.192.168.0/21"
  public_subnets     = ["10.192.168.0/24", "10.192.169.0/24", "10.192.170.0/24"]
  private_subnets    = ["10.192.173.0/24", "10.192.171.0/24", "10.192.172.0/24"]
  enable_nat_gateway = true
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "default-terraform-common-terraform-state"
    key            = "tf/tf-demo/terraform.tfstate"
    dynamodb_table = "terraform-statelock"
    profile        = "default"
    region         = "us-west-2"
  }
}
