variable "region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "route53_domain_certificate_arn" {
  description = "Domain certificate ARN from ACM"
  type        = string
}

variable "vpc_nat_eip" {
  description = "NAT gateway elastic IP address"
  type        = string
}