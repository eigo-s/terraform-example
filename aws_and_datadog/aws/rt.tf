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

resource "aws_route_table_association" "public-rtba-public1a" {
  route_table_id = "${aws_route_table.public1a-rtb.id}"
  subnet_id      = "${aws_subnet.public1a-subnet.id}"
}
