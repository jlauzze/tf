variable "name" {
  description = "alb Name"
  type        = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "private_zone_id" {
  description = "id of our private dns zone"
  type        = string
}

variable "public_zone_id" {
  description = "id of our public dns zone"
  type        = string
}

variable "internal" {
  description = "whether or not to operate the ALB in internal only mode"
  type        = bool
}

variable "security_groups" {
  description = "security groups to apply to ALB listeners"
  type        = list(string)
}

variable "cidr_blocks" {
  description = "security groups to apply to ALB listeners"
  type        = list(string)
  default     = []
}

variable "backend_security_groups" {
  description = "the security groups that are already applied to the backend instances"
  type        = list(string)
}

variable "subnets" {
  description = "which subnets the ALB's listeners should belong to"
  type        = list(string)
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application."
  type        = number
  default     = 60
}

variable "insecure_port" {
  description = "what port a non tls listener should listen on"
  type        = number
  default     = null
}

variable "secure_port" {
  description = "what port a tls listener should listen on"
  type        = number
  default     = null
}

variable "ssl_arn" {
  description = "arn of the ACM certificate to use on the secure port"
  type        = string
  default     = ""
}

variable "additional_certificates" {
  description = "a list of additional SSL certificates to attach to the secure port"
  type        = list(string)
  default     = []
}

variable "backend_protocol" {
  description = "protocol the backend is listening on"
  type        = string
  default     = "tcp"
}

variable "backend_port_override" {
  description = "target port when forwarding to a different backend port"
  type        = number
  default     = null
}

variable "target_type" {
  description = "type of backend target, instance, ip, lambda"
  type        = string
  default     = "instance"
}

variable "target_protocol" {
  description = "target protocol (HTTP, HTTPS)"
  type        = string
  default     = "HTTPS"
}

variable "deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds"
  type        = number
  default     = 300
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds"
  type        = number
  default     = 30
}

variable "health_check_protocol" {
  description = "The protocol to use to connect with the target. Defaults to HTTP. Not applicable when target_type is lambda."
  type        = string
  default     = "HTTP"
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
  type        = number
  default     = 3
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy . For Network Load Balancers, this value must be the same as the healthy_threshold"
  type        = number
  default     = 3
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check. For Application Load Balancers, the range is 2 to 120 seconds, and the default is 5 seconds for the instance target type and 30 seconds for the lambda target type"
  type        = number
  default     = 5
}

variable "health_check_port" {
  description = "The port to use to connect with the target. Valid values are either ports 1-65535, or traffic-port. Defaults to traffic-port."
  type        = string
  default     = "traffic-port"
}

variable "health_check_path" {
  description = "The destination for the health check request."
  type        = string
  default     = "/"
}

variable "stickiness" {
  description = "The type of sticky sessions"
  type        = string
  default     = "lb_cookie"
}

variable "target_group_matcher" {
  description = "(Required for HTTP/HTTPS ALB) The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, '200,202') or a range of values (for example, '200-299')"
  type        = string
  default     = "200,307,429"
}

variable "dns_suffix" {
  type = string
}

variable "load_balancing_account_ids" {
  description = "accounts that ELB access logs will come from, needed for s3 access log permissions"
  type        = map(string)
  default = {
    us-east-1      = "127311923021",
    us-east-2      = "033677994240",
    us-west-1      = "027434742980",
    us-west-2      = "797873946194",
    ca-central-1   = "985666609251",
    eu-central-1   = "054676820928",
    eu-west-1      = "156460612806",
    eu-west-2      = "652711504416",
    eu-west-3      = "009996457667",
    eu-north-1     = "897822967062",
    ap-east-1      = "754344448648",
    ap-northeast-1 = "582318560864",
    ap-northeast-2 = "600734575887",
    ap-northeast-3 = "383597477331",
    ap-southeast-1 = "114774131450",
    ap-southeast-2 = "783225319266",
    ap-south-1     = "718504428378",
    me-south-1     = "076674570225",
    sa-east-1      = "507241528517",
    us-gov-west-1  = "048591011584",
    us-gov-east-1  = "190560391635",
    cn-north-1     = "638102146993",
    cn-northwest-1 = "037604701340",
  }
}
