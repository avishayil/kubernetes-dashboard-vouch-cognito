variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
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