resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "bastion-sg"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "${element(var.batsion_ingress_cidr_blocks,count.index)}",
    ]

    self = true
  }

  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "Name" = "bastion-sg"
  }
}

resource "aws_security_group" "private-mysql-sg" {
  name        = "private-mysql-sg"
  description = "private-mysql-sg"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.bastion-sg.id}",
    ]

    self = true
  }

  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"

    security_groups = [
      "${aws_security_group.bastion-sg.id}",
    ]

    self = false
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "Name" = "private-mysql-sg"
  }
}
