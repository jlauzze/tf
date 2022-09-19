variable "name" {
  type    = string
  default = "demo"
}

variable "environment" {
  type    = string
  default = "demo-tf"
}
variable "dns_suffix" {
  type    = string
  default = "joe.lauzze.com"
}
variable "instance_size" {
  type = string
  default = "t3.nano"
}

variable "subnets" {
  description = "list of subnets to open the nlb to"
  type        = list(string)
  default     = []
}

variable "group_size" {
  description = "ASG sizing per env"
  type        = map(number)
  default = {
      min_size         = 3,
      max_size         = 3,
      desired_capacity = 3
  }
}
