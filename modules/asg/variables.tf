variable "name" {
  description = "name of the service"
  type        = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}

variable "cloud-init" {
  description = "rendered template to use"
  type        = string
  default     = null
}

variable "user-data" {
  description = "rendered userdata template"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "class of ec2 instance"
  type        = string
}

variable "key_name" {
  description = "name of the ssh key to use"
  type        = string
  default     = "emergency_ssh_key"
}

variable "public_ip" {
  description = "whether or not to allocate a public IP for instances in this ASG"
  type        = bool
}

variable "iam_instance_profile" {
  description = "iam role to use on these instances"
  type        = string
}

variable "security_groups" {
  description = "list of security groups to attach to the instances"
  type        = list(string)
}

variable "root_volume_type" {
  description = "type of volume to use on instance root"
  type        = string
  default     = "gp2"
}

variable "root_volume_size" {
  description = "size of root volume"
  type        = number
  default     = 20
}

variable "additional_volumes" {
  description = "an array of objects describing any additional volumes needed"
  type        = list(any)
  default     = []
}

variable "subnets" {
  description = "subnets to put instances in for this asg"
  type        = list(string)
}

variable "min_size" {
  description = "minimum number of instances needed"
  type        = number
}

variable "max_size" {
  description = "maximum number of instances needed"
  type        = number
}

variable "desired_capacity" {
  description = "desired number of nodes in cluster"
  type        = number
}

variable "health_check_grace_period" {
  description = "how long a health check must fail before marking an instance as out"
  type        = number
  default     = 300
}

variable "health_check_type" {
  description = "what type of health check to use"
  type        = string
  default     = "ELB"
}

variable "load_balancers" {
  description = "id's of load balancers you want attached to this asg"
  type        = list(string)
  default     = []
}

variable "target_group_arns" {
  description = "list of target groups to associate with this ASG (needed for albs)"
  type        = list(string)
  default     = []
}

variable "scaling_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = null
}

variable "suspended_processes" {
  description = "a list of suspended scaling processes for this asg. Typically used to disable termination or auto-replacement"
  type        = list(string)
  default     = []
}
