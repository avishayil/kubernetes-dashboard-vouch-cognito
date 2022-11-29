resource "aws_route53_record" "vouch" {
  zone_id = var.route53_hosted_zone_id
  name    = "vouch.${var.route53_domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = ["${var.route53_domain_name}"]
}

resource "aws_route53_record" "k8sdashboard" {
  zone_id = var.route53_hosted_zone_id
  name    = "k8sdashboard.${var.route53_domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = ["${var.route53_domain_name}"]
}