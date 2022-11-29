module "lb_controller" {
  source = "./lb-controller"

  cluster_name                 = var.cluster_name
  cluster_identity_oidc_issuer = var.cluster_identity_oidc_issuer
  env                          = var.env
}

module "ingress_nginx" {
  source = "./ingress-nginx"

  region = var.region

  cluster_name                   = var.cluster_name
  route53_domain_certificate_arn = var.route53_domain_certificate_arn
  vpc_nat_eip                    = var.vpc_nat_eip

  depends_on = [module.lb_controller]
}

module "vouch_proxy" {
  source = "./vouch-proxy"

  region = var.region

  cluster_identity_oidc_issuer    = var.cluster_identity_oidc_issuer
  user_email_domain               = var.user_email_domain
  route53_domain_name             = var.route53_domain_name
  cognito_user_pool_client_id     = var.cognito_user_pool_client_id
  cognito_user_pool_client_secret = var.cognito_user_pool_client_secret
  cognito_user_pool_domain        = var.cognito_user_pool_domain

  depends_on = [module.ingress_nginx]
}

module "kubernetes_dashboard" {
  source = "./kubernetes-dashboard"

  route53_domain_name = var.route53_domain_name

  depends_on = [module.vouch_proxy]
}

module "dns_updater" {
  source = "./dns-updater"

  region                 = var.region
  cluster_name           = var.cluster_name
  route53_domain_name    = var.route53_domain_name
  route53_hosted_zone_id = var.route53_hosted_zone_id

  depends_on = [module.vouch_proxy, module.kubernetes_dashboard]
}

module "rbac_roles" {
  source = "./rbac-roles"
}