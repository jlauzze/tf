variable "automation" {
  default = "terraform"
  type    = string
}

variable "profile" {
  type = string
  default = "default"
}

variable "repo_name" {
  default = "tf"
  type    = string
}

#variable "repo_path" {
#  default = "modules/remote-state"
#  type    = string
#}
