variable "name" {
  description = "demo-tf"
  type        = string
}

variable "environment" {}
variable "dns_suffix" {}
variable "instance_size" {}

variable "group_size" {
  type = map
}

variable "ami_owners" {
  type = list(string)
}

variable "ami_filters" {
  type = map(string)
}

variable "subnets" {
  description = "list of subnets to open the nlb to"
  type        = list(string)
  default     = []
}
