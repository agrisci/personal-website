# EC2
resource "aws_security_group" "ec2_instances_sg" {
  name        = "ec2_instances_security_group"
  description = "EC2 Instances Security Group"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "ssh_to_instance_ingress" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  security_group_id = aws_security_group.ec2_instances_sg.id
  cidr_blocks       = ["${chomp(data.http.my_public_ip.response_body)}/32"]
}

resource "aws_security_group_rule" "instance_ingress" {
  type      = "ingress"
  from_port = var.apps_port_start
  to_port   = var.apps_port_end
  protocol  = "tcp"

  security_group_id        = aws_security_group.ec2_instances_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "instance_egress" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id = aws_security_group.ec2_instances_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "ALB_Security Group"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "alb_http_ingress" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_https_ingress" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress" {
  type      = "egress"
  from_port = var.apps_port_start
  to_port   = var.apps_port_end
  protocol  = "tcp"

  security_group_id        = aws_security_group.alb_sg.id
  source_security_group_id = aws_security_group.ec2_instances_sg.id
}