output "repository_url" {
  value = "${aws_ecr_repository.nginx_app.repository_url}"
}

output "cluster_name" {
  value = "${aws_ecs_cluster.cluster.name}"
}

output "service_name" {
  value = "${aws_ecs_service.web.name}"
}

output "alb_zone_id" {
  value = "${aws_alb.alb_nginx.zone_id}"
}

output "security_group_id" {
  value = "${aws_security_group.ecs_service.id}"
}
