variable "ecs_cluster" {
  name = "${var.ecs_cluster}"
  default = "terraform_ecs-cluster"
}

variable "repository_name" {
  name = "${var.repository_name}"
  default = "nginx_app"
}

variable "service_name" {
  name = "${var.service_name}"
  default = "terraform_web"
}

variable "vpc_id" {
  description = "The VPC id"
}
