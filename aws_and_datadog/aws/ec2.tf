data "template_file" "bastion_user_data" {
  template = "${file("${path.module}/user_data.tpl")}"

  vars {
    host = "bastion${format("%03d", count.index + 1)}"
  }
}

resource "aws_key_pair" "bastion-key_pair" {
  key_name   = "bastion"
  public_key = "${var.bastion_public_key}"
}

resource "aws_eip" "bastion-eip" {
  vpc = true
}

resource "aws_eip_association" "bastion-eip_assoc" {
  instance_id   = "${aws_instance.bastion.id}"
  allocation_id = "${aws_eip.bastion-eip.id}"
}

resource "aws_instance" "bastion" {
  ami = "ami-383c1956"

  availability_zone = "ap-northeast-1a"
  ebs_optimized     = false
  instance_type     = "${var.bastion_instance_type}"
  monitoring        = false
  key_name          = "${aws_key_pair.bastion-key_pair.key_name}"
  subnet_id         = "${aws_subnet.public1a-subnet.id}"

  vpc_security_group_ids = [
    "${aws_security_group.bastion-sg.id}",
  ]

  associate_public_ip_address = true
  source_dest_check           = true

  user_data = "${data.template_file.bastion_user_data.rendered}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.bastion_volume_size}"
    delete_on_termination = true
  }

  tags {
    "Name" = "bastion${format("%03d", count.index + 1)}"
    "Role" = "bastion"
    "Env"  = "${var.env}"
  }
}

resource "null_resource" "install_datadog_agent" {
  triggers {
    bastion_id = "${aws_instance.bastion.id}"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = "${aws_eip.bastion-eip.public_ip}"
      user        = "${var.bastion_user}"
      private_key = "${file("${path.module}/bastion.pem")}"
    }

    inline = [
      "DD_API_KEY=${var.datadog_api_key} bash -c \"$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)\"",
    ]
  }
}


output "bastion_public_ip" {
  value = "${aws_eip.bastion-eip.public_ip}"
}
