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

resource "aws_subnet" "public1c-subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public1c_subnet_cidr}"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags {
    "Name" = "public1c-subnet"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private1a-subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private1a_subnet_cidr}"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags {
    "Name" = "private1a-subnet"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private1c-subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private1c_subnet_cidr}"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags {
    "Name" = "private1c-subnet"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "ngw1a-eip" {
  vpc = true
}

resource "aws_eip" "ngw1c-eip" {
  vpc = true
}

resource "aws_nat_gateway" "ngw1a" {
  allocation_id = "${aws_eip.ngw1a-eip.id}"
  subnet_id     = "${aws_subnet.public1a-subnet.id}"
}

resource "aws_nat_gateway" "ngw1c" {
  allocation_id = "${aws_eip.ngw1c-eip.id}"
  subnet_id     = "${aws_subnet.public1c-subnet.id}"
}
