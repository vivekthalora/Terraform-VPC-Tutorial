/* Creating a VPC */

resource "aws_vpc" "LAMP_TF_vpc" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "LAMP_TF_vpc"
    Location = "Bangalore"
    Admin = "Vivek P V"
    E-mail = "vivekpv@riktech.co.in"
  }
}

/* Creating a NAT Gateway, Adding Route Table,
Creating Public Subnet and Associating Subnet with Route Table */

resource "aws_internet_gateway" "LAMP_TF_vpc_inet_gw" {
  vpc_id = "${aws_vpc.LAMP_TF_vpc.id}"

  tags = {
    Name = "LAMP_TF_vpc_inet_gw"
  }
}

resource "aws_route_table" "LAMP_public_rt" {
  vpc_id = "${aws_vpc.LAMP_TF_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.LAMP_TF_vpc_inet_gw.id}"
  }

  tags = {
    Name = "LAMP_public_rt"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = "${aws_vpc.LAMP_TF_vpc.id}"
  cidr_block = "${var.public_subnet_cidr}"

  tags {
    Name = "public_subnet1"
    Description = "Web Public Subnet"
  }
}

resource "aws_route_table_association" "LAMP_public_rt" {
  subnet_id = "${aws_subnet.public_subnet1.id}"
  route_table_id = "${aws_route_table.LAMP_public_rt.id}"
}

/* Creating an Elastic IP, Allocating NAT Gateway, Adding Route Table,
Creating Private Subnet and Associating Subnet with Route Table */

resource "aws_eip" "LAMP_private_nat" {
  vpc = true
}

resource "aws_nat_gateway" "LAMP_TF_vpc_nat_gw" {
  allocation_id = "${aws_eip.LAMP_private_nat.id}"
  subnet_id = "${aws_subnet.public_subnet1.id}"
  depends_on = ["aws_internet_gateway.LAMP_TF_vpc_inet_gw"]
  tags = {
    Name = "LAMP_TF_vpc_nat_gw"
  }
}

resource "aws_route_table" "LAMP_private_rt" {
  vpc_id = "${aws_vpc.LAMP_TF_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.LAMP_TF_vpc_nat_gw.id}"
  }

  depends_on = [
    "aws_vpc.LAMP_TF_vpc",
    "aws_nat_gateway.LAMP_TF_vpc_nat_gw"
  ]

  tags = {
    Name = "LAMP_private_rt"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = "${aws_vpc.LAMP_TF_vpc.id}"
  cidr_block = "${var.private_subnet_cidr}"

  tags = {
    Name = "private_subnet1"
    Description = "Subnet for private access to DB"
  }
}

resource "aws_route_table_association" "LAMP_private_rt" {
    subnet_id = "${aws_subnet.private_subnet1.id}"
    route_table_id = "${aws_route_table.LAMP_private_rt.id}"
}

/* Define the security group for LAMP public subnet */
resource "aws_security_group" "LAMP_vpc_web_sg" {
  name = "LAMP_vpc_web"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.LAMP_TF_vpc.id}"

  tags {
    Name = "LAMP Web Server SG"
  }
}

# Define the security group for LAMP private subnet
resource "aws_security_group" "LAMP_vpc_db_sg"{
  name = "LAMP_vpc_db"
  description = "Allow traffic from private subnet"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.LAMP_TF_vpc.id}"

  tags {
    Name = "LAMP DB Server SG"
  }
}

