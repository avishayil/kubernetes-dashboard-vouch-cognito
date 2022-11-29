variable "region" {
  description = "AWS region"
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

variable "route53_domain_name" {
  description = "Route53 root domain name"
  type        = string
}

variable "user_email_domain" {
  description = "Email domain to approve using oauth"
  type        = string
}

variable "cluster_identity_oidc_issuer" {
  description = "EKS cluster identity oidc issuer"
  type        = string
}