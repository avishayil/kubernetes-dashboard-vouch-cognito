module "vpc" {
  source = "./vpc"

  project_name = var.project_name
  env          = var.env
  region       = var.region
}

module "route53" {
  source = "./route53"

  route53_domain_name    = var.route53_domain_name
  route53_hosted_zone_id = var.route53_hosted_zone_id
}

module "cognito" {
  source = "./cognito"

  project_name = var.project_name
  env          = var.env
  region       = var.region

  route53_domain_name = var.route53_domain_name
}

module "eks" {
  source = "./eks"

  project_name = var.project_name
  env          = var.env
  region       = var.region

  vpc_id                      = module.vpc.vpc_id
  vpc_private_subnet_ids      = module.vpc.vpc_private_subnet_ids
  cognito_user_pool_client_id = module.cognito.cognito_user_pool_client_id
  cognito_user_pool_endpoint  = module.cognito.cognito_user_pool_endpoint
}