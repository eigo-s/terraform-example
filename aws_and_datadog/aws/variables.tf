variable "env" {
  default = "global"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "public1a_subnet_cidr" {
  default = "10.1.0.0/24"
}

variable "public1c_subnet_cidr" {
  default = "10.1.1.0/24"
}

variable "private1a_subnet_cidr" {
  default = "10.1.11.0/24"
}

variable "private1c_subnet_cidr" {
  default = "10.1.12.0/24"
}

variable "bastion_instance_type" {
  default = "t2.nano"
}

variable "bastion_volume_size" {
  default = "50"
}

variable "bastion_public_key" {
  default = "your public key"
}

variable "batsion_ingress_cidr_blocks" {
  type = "list"

  default = [
    "0.0.0.0/0",
  ]
}

variable "bastion_user" {
  default = "ec2-user"
}

variable "datadog_external_id" {
  default = ""
}
