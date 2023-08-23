output "ecs_instance_1a_public_ip" {
  value = aws_instance.ecs_instance_1a.public_ip
}

output "ecs_instance_1a_dns_name" {
  value = aws_instance.ecs_instance_1a.public_dns
}

output "alb_dns_name" {
  value = aws_lb.load_balancer.dns_name
}