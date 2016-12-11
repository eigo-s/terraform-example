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

variable "builder_instance_type" {
  default = "t2.nano"
}

variable "builder_volume_size" {
  default = "50"
}

variable "builder_public_key" {
  default = "your public key"
}

variable "batsion_ingress_cidr_blocks" {
  type = "list"

  default = [
    "0.0.0.0/0",
  ]
}

variable "rds_family" {
  default = "mysql5.6"
}

variable "rds_username" {
  default = "terraform"
}

variable "rds_password" {
  default = "password"
}

variable "rds_engine_version" {
  default = "5.6.29"
}

variable "rds_instance_class" {
  default = "db.t2.micro"
}

variable "rds_first_db" {
  default = "first"
}

variable "rds_second_db" {
  default = "second"
}

variable "rds_master_allocated_storage" {
  default = "20"
}

variable "rds_replica_allocated_storage" {
  default = "20"
}

variable "bastion_user" {
  default = "ec2-user"
}
