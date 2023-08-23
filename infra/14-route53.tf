resource "aws_route53domains_registered_domain" "registered_domain" {
  domain_name = var.registered_domain
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.registered_domain.id
  name    = "www"
  type    = "CNAME"
  ttl     = 300
  records = [var.registered_domain]
}

resource "aws_route53_record" "www_dev" {
  zone_id = data.aws_route53_zone.registered_domain.id
  name    = "www.dev"
  type    = "CNAME"
  ttl     = 300
  records = ["dev.${var.registered_domain}"]
}

resource "aws_route53_record" "base_domain" {
  zone_id = data.aws_route53_zone.registered_domain.id
  name    = var.registered_domain
  type    = "A"
  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "dev" {
  zone_id = data.aws_route53_zone.registered_domain.id
  name    = "dev.${var.registered_domain}"
  type    = "A"
  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = false
  }
}