output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "subnet_a" {
  value = ["${aws_subnet.subnet_a.*.id}"]
}

output "default_sg_id" {
  value = "${aws_security_group.default.id}"
}

output "security_groups_ids" {
  value = ["${aws_security_group.default.id}"]
}
