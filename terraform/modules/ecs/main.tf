/*====
Cloudwatch Log Group
======*/
resource "aws_cloudwatch_log_group" "nginx" {
  name = "nginx"

  tags {
    Application = "nginx"
  }
}

/*====
ECR repository to store our Docker images
======*/
resource "aws_ecr_repository" "nginx_app" {
  name = "${var.repository_name}"
}

/*====
ECS cluster
======*/
resource "aws_ecs_cluster" "cluster" {
  name = "${var.ecs_cluster}"
}

/*====
ECS task definitions
======*/

/* the task definition for the web service */
data "template_file" "web_task" {
  template = "${file("${path.module}/tasks/web_task_definition.json")}"

  vars {
    image           = "${aws_ecr_repository.nginx_app.repository_url}"
    secret_key_base = "${var.secret_key_base}"
    log_group       = "${aws_cloudwatch_log_group.nginx.name}"
  }
}

resource "aws_ecs_task_definition" "web" {
  family                   = "${var.service_name}_web"
  container_definitions    = "${data.template_file.web_task.rendered}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "${aws_iam_role.ecs_execution_role.arn}"
  task_role_arn            = "${aws_iam_role.ecs_execution_role.arn}"
}

/*====
ECS service
======*/

/* Security Group for ECS */
resource "aws_security_group" "ecs_service" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.service_name}-ecs-service-sg"
  description = "Allow egress from container"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.service_name}-ecs-service-sg"
  }
}
