output "cluster_name" {
  value = module.cloud.cluster_name
}

output "cluster_endpoint" {
  value = module.cloud.cluster_endpoint
}

output "cluster_identity_oidc_issuer" {
  value = module.cloud.cluster_identity_oidc_issuer
}

output "cluster_ca_certificate" {
  value     = module.cloud.cluster_ca_certificate
  sensitive = true
}