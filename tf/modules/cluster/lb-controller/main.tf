module "lb_controller" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-lb-controller.git"

  cluster_name                     = var.cluster_name
  cluster_identity_oidc_issuer     = var.cluster_identity_oidc_issuer
  cluster_identity_oidc_issuer_arn = "arn:aws:iam::${local.account_id}:oidc-provider/${split("//", var.cluster_identity_oidc_issuer)[1]}"
}