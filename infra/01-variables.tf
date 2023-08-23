variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "availability_zone_a" {
  type    = string
  default = "eu-central-1a"
}

variable "availability_zone_b" {
  type    = string
  default = "eu-central-1b"
}

variable "registered_domain" {
  type    = string
}

variable "apps_port_start" {
  type    = number
}

variable "apps_port_end" {
  type    = number
}

variable "ssh_public_key_file" {
  type = string
}