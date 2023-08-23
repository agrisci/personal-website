resource "aws_route53domains_registered_domain" "registered_domain" {
  domain_name = var.registered_domain
}

resource "aws_route53_record" "apex" {
  zone_id = data.aws_route53_zone.my_domain_zone.id
  name    = var.registered_domain
  type    = "A"
  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.my_domain_zone.id
  name    = "www.${var.registered_domain}"
  type    = "A"
  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "dev" {
  zone_id = data.aws_route53_zone.my_domain_zone.id
  name    = "dev.${var.registered_domain}"
  type    = "A"
  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_dev" {
  zone_id = data.aws_route53_zone.my_domain_zone.id
  name    = "www.dev.${var.registered_domain}"
  type    = "A"
  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = false
  }
}