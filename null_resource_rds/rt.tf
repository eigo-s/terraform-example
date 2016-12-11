resource "aws_route_table" "public1a-rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    "Name" = "public1a-rtb"
  }
}

resource "aws_route_table" "public1c-rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    "Name" = "public1c-rtb"
  }
}

resource "aws_route_table" "private1a-rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw1a.id}"
  }

  tags {
    "Name" = "private1a-rtb"
  }
}

resource "aws_route_table" "private1c-rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.ngw1c.id}"
  }

  tags {
    "Name" = "private1c-rtb"
  }
}

resource "aws_route_table_association" "public-rtba-public1a" {
  route_table_id = "${aws_route_table.public1a-rtb.id}"
  subnet_id      = "${aws_subnet.public1a-subnet.id}"
}

resource "aws_route_table_association" "public-rtba-public1c" {
  route_table_id = "${aws_route_table.public1c-rtb.id}"
  subnet_id      = "${aws_subnet.public1c-subnet.id}"
}

resource "aws_route_table_association" "private-rtba-private1a" {
  route_table_id = "${aws_route_table.private1a-rtb.id}"
  subnet_id      = "${aws_subnet.private1a-subnet.id}"
}

resource "aws_route_table_association" "private-rtba-private1c" {
  route_table_id = "${aws_route_table.private1c-rtb.id}"
  subnet_id      = "${aws_subnet.private1c-subnet.id}"
}
