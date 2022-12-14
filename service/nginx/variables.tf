variable "name" {
  type    = string
  default = "demo-alb"
}

variable "environment" {
  type    = string
  default = "demo-tf"
}
variable "dns_suffix" {
  type    = string
  default = "lauzze.link"
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
      min_size         = 2,
      max_size         = 2,
      desired_capacity = 2
  }
}
