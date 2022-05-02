variable "ami" {
  type = string
}

variable "key" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "network_interface_id" {
  type = string
}

variable "security" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "userdata" {
  type = string
}    