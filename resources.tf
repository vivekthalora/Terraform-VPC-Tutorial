
# Define Ansible Bastion Host in public subnet
resource "aws_instance" "ansible-server" {
   ami = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.LAMP_key_pair.id}"
   iam_instance_profile = "${aws_iam_instance_profile.ansible-iam-instance-profile.name}"
   subnet_id = "${aws_subnet.public_subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.LAMP_vpc_web_sg.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("setup-lnxcfg-user.sh")}"

  tags {
    Name = "Ansible Bastion Host"
  }
}

# Define Apache Webserver inside the public subnet
resource "aws_instance" "apache-web" {
   ami = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.LAMP_key_pair.id}"
   subnet_id = "${aws_subnet.public_subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.LAMP_vpc_web_sg.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("setup-lnxcfg-user.sh")}"

  tags {
    Name = "Apache Webserver"
  }
}

# Define MySQL Database inside the private subnet
resource "aws_instance" "mysql-db" {
   ami = "${var.ami}"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.LAMP_key_pair.id}"
   subnet_id = "${aws_subnet.private_subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.LAMP_vpc_db_sg.id}"]
   source_dest_check = false
   user_data = "${file("setup-lnxcfg-user.sh")}"

  tags {
    Name = "MySQL Database"
  }
}
