variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.30.0.0/24"
}

variable "vpc_namer" {
  name = "${var.vpc_name}"
  default = "vpc_terraform"
}
