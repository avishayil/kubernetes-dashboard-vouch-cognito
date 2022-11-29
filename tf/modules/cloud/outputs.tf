output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_identity_oidc_issuer" {
  value = module.eks.cluster_identity_oidc_issuer
}

output "cluster_ca_certificate" {
  value     = module.eks.cluster_ca_certificate
  sensitive = true
}

output "vpc_nat_eip" {
  value     = module.vpc.vpc_nat_eip
  sensitive = true
}

output "cognito_user_pool_client_id" {
  value = module.cognito.cognito_user_pool_client_id
}

output "cognito_user_pool_client_secret" {
  value     = module.cognito.cognito_user_pool_client_secret
  sensitive = true
}

output "cognito_user_pool_domain" {
  value = module.cognito.cognito_user_pool_domain
}

output "cognito_user_pool_endpoint" {
  value = module.cognito.cognito_user_pool_endpoint
}