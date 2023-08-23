data "http" "my_public_ip" {
  url = "http://ifconfig.io"
}

data "aws_route53_zone" "registered_domain" {
  name = var.registered_domain
}

data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}