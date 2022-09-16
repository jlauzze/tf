variable "name" {
  type    = string
  default = "demo-tf"
}

variable "environment" {
  type    = string
  default = "demo-tf"
}
variable "dns_suffix" {
  type    = string
  default = ""
}
variable "instance_size" {
  type = map(string)
  default = {
    demo = "t3.nano"
  }
}

#variable "group_size" {
#  type = map(any)
#}

variable "subnets" {
  description = "list of subnets to open the nlb to"
  type        = list(string)
  default     = []
}

variable "group_size" {
  description = "ASG sizing per env"
  type        = map(map(number))
  default = {
    demo = {
      min_size         = 3,
      max_size         = 3,
      desired_capacity = 3
    }
  }
}
