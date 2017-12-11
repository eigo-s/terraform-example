resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags {
    "Name" = "vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    "Name" = "igw"
  }
}

resource "aws_subnet" "public1a-subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public1a_subnet_cidr}"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags {
    "Name" = "public1a-subnet"
  }

  lifecycle {
    create_before_destroy = true
  }
}
