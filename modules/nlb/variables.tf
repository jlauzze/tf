variable "name" {
  description = "alb Name"
  type        = string
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "internal" {
  description = "whether or not to operate the ALB in internal only mode"
  type        = bool
}

variable "subnets" {
  description = "list of subnets to open the nlb to"
  type        = list(string)
}

variable "port" {
  description = "what port the nlb should use"
  type        = number
  default     = null
}

variable "protocol" {
  description = "protocol the backend is listening on"
  type        = string
  default     = "TCP"
}

variable "target_type" {
  description = "type of backend target, instance, ip, lambda"
  type        = string
  default     = "instance"
}

variable "private_zone_id" {
  description = "id of our private dns zone"
  type        = string
}

variable "public_zone_id" {
  description = "id of our public dns zone"
  type        = string
}

variable "interval" {
  description = "health check interval"
  type        = number
  default     = 30
}

variable "healthy_threshold" {
  description = "health check healthy threshold"
  type        = number
  default     = 10
}

variable "unhealthy_threshold" {
  description = "health check unhealthy threshold"
  type        = number
  default     = 10
}

variable "slow_start" {
  description = "how long to wait before sending traffic to a target"
  type        = number
  default     = 0
}
