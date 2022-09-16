provider "aws" {
  profile = var.profile
  region  = "us-west-2"
}

variable "aws_account_id" {
  default = "756717229274"
  type    = string
}

variable "automation" {
  default = "terraform"
  type    = string
}

variable "profile" {
  default = "default"
  type    = string
}

variable "region" {
  default = "us-west-2"
  type    = string
}

variable "repo_name" {
  default = "tf"
  type    = string
}

variable "tf_s3_bucket" {
  default = "tf-demo-terraform-state"
  type    = string
}
