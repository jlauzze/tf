variable "name" {
  description = "demo-tf"
  type        = string
}

variable "environment" {
  type = string
  default = "demo-tf"
}
variable "dns_suffix" {}
variable "instance_size" {
  type = string
  default = "t3.nano"
}

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
