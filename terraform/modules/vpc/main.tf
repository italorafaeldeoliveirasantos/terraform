resource "aws_vpc" "VPC_Terraform" {
  vpc_id               = "${aws_vpc.vpc.id}"
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    label = "VPC_Terraform"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private_subnet_cidr}"
  availability_zone       = "${var.aws_region}"
  map_public_ip_on_launch = false

  tags {
    Name = "subnet_a"
  }
}

resource "aws_security_group" "default" {
  name        = "${var.vpc_name}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  depends_on  = ["aws_vpc.VPC_Terraform"]

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags {
    Environment = "${var.vpc_name-sg}"
  }
}
