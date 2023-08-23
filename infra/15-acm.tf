resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.email
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.registration.account_key_pem
  common_name               = data.aws_route53_zone.registered_domain.name
  subject_alternative_names = ["*.${data.aws_route53_zone.registered_domain.name}", "*.dev.${data.aws_route53_zone.registered_domain.name}"]

  dns_challenge {
    provider = "route53"
  }

  depends_on = [acme_registration.registration]
}

resource "aws_acm_certificate" "acm_certificate" {
  certificate_body  = acme_certificate.certificate.certificate_pem
  private_key       = acme_certificate.certificate.private_key_pem
  certificate_chain = acme_certificate.certificate.issuer_pem
}