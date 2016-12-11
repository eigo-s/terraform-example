resource "aws_db_subnet_group" "rds-subnet" {
  name        = "rds-subnet"
  description = "rds-subnet"

  subnet_ids = [
    "${aws_subnet.private1a-subnet.id}",
    "${aws_subnet.private1c-subnet.id}",
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "rds-subnet"
  }
}

resource "aws_db_parameter_group" "rds-pg" {
  name        = "rds-pg"
  family      = "${var.rds_family}"
  description = "RDS PG"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }

  parameter {
    name  = "max_connections"
    value = "2048"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "2"
  }
}

resource "aws_db_instance" "rds-master" {
  identifier              = "rds-master"
  allocated_storage       = "${var.rds_master_allocated_storage}"
  engine                  = "mysql"
  engine_version          = "${var.rds_engine_version}"
  instance_class          = "${var.rds_instance_class}"
  storage_type            = "gp2"
  multi_az                = true
  name                    = "${var.rds_first_db}"
  username                = "${var.rds_username}"
  password                = "${var.rds_password}"
  db_subnet_group_name    = "${aws_db_subnet_group.rds-subnet.id}"
  vpc_security_group_ids  = ["${aws_security_group.private-mysql-sg.id}"]
  parameter_group_name    = "${aws_db_parameter_group.rds-pg.id}"
  backup_retention_period = 7
  maintenance_window      = "Tue:04:00-Tue:04:30"
  publicly_accessible     = false

  tags {
    "Name" = "rds-master"
  }
}

resource "aws_db_instance" "rds-replica" {
  identifier              = "rds-replica"
  allocated_storage       = "${var.rds_replica_allocated_storage}"
  replicate_source_db     = "${aws_db_instance.rds-master.identifier}"
  engine                  = "mysql"
  engine_version          = "${var.rds_engine_version}"
  instance_class          = "${var.rds_instance_class}"
  storage_type            = "gp2"
  name                    = "${var.rds_first_db}"
  username                = "${var.rds_username}"
  password                = "${var.rds_password}"
  vpc_security_group_ids  = ["${aws_security_group.private-mysql-sg.id}"]
  parameter_group_name    = "${aws_db_parameter_group.rds-pg.id}"
  backup_retention_period = 7
  maintenance_window      = "Tue:04:00-Tue:04:30"
  publicly_accessible     = false

  tags {
    "Name" = "rds-replica"
  }
}
