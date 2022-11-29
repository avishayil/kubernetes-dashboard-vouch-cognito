variable "project_name" {
  description = "Name to be used on all the resources as identifier. e.g. Project name, Application name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_identity_oidc_issuer" {
  description = "EKS cluster identity oidc issuer"
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

variable "vpc_nat_eip" {
  description = "NAT gateway elastic IP address"
  type        = string
}

variable "cognito_user_pool_client_id" {
  description = "Cognito user pool client ID"
  type        = string
}

variable "cognito_user_pool_client_secret" {
  description = "Cognito user pool client secret"
  type        = string
}

variable "cognito_user_pool_domain" {
  description = "Cluster user pool generated subdomain"
  type        = string
}
