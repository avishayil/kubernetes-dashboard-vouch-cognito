variable "project_name" {
  description = "Name to be used on all the resources as identifier. e.g. Project name, Application name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "route53_domain_name" {
  description = "Route53 root domain name"
  type        = string
}

variable "route53_hosted_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "route53_domain_certificate_arn" {
  description = "Domain certificate ARN from ACM"
  type        = string
}

variable "user_email_domain" {
  description = "Email domain to approve using oauth"
  type        = string
}