resource "null_resource" "create-second-db" {
  triggers {
    endpoint = "${aws_db_instance.rds-master.endpoint}"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = "${aws_instance.bastion.public_dns}"
      user        = "${var.bastion_user}"
      private_key = "${file("${path.module}/bastion.pem")}"
    }

    inline = [
      "sudo yum -y install mysql",
      "mysql -u${var.rds_username} -p${var.rds_password} -h${aws_db_instance.rds-master.address} -e\"create database ${var.rds_second_db};\"",
    ]
  }
}
