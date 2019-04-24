variable "aws_region" {
  description = "Default AWS region for the LAMP_VPC"
  default = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "192.168.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "192.168.2.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default = "192.168.1.0/24"
}

variable "ami" {
  description = "UltraServe CentOS 7.4 AMI"
  default = "ami-03a199c8ef85f8f23"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "public_key"
}

