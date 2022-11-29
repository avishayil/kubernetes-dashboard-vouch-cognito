locals {
  env = "dev"
}

module "cloud" {
  source = "../../modules/cloud"

  project_name = var.project_name
  env          = local.env
  region       = var.region

  route53_domain_name    = var.route53_domain_name
  route53_hosted_zone_id = var.route53_hosted_zone_id
}

module "cluster" {
  source = "../../modules/cluster"

  project_name = var.project_name
  env          = local.env
  region       = var.region

  route53_domain_name             = var.route53_domain_name
  route53_hosted_zone_id          = var.route53_hosted_zone_id
  route53_domain_certificate_arn  = var.route53_domain_certificate_arn
  user_email_domain               = var.user_email_domain
  cluster_name                    = module.cloud.cluster_name
  cluster_identity_oidc_issuer    = module.cloud.cluster_identity_oidc_issuer
  vpc_nat_eip                     = module.cloud.vpc_nat_eip
  cognito_user_pool_client_id     = module.cloud.cognito_user_pool_client_id
  cognito_user_pool_client_secret = module.cloud.cognito_user_pool_client_secret
  cognito_user_pool_domain        = module.cloud.cognito_user_pool_domain

  depends_on = [module.cloud]
}
