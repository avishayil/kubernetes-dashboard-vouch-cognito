variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_identity_oidc_issuer" {
  description = "EKS cluster identity oidc issuer"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}