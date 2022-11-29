module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.6"

  cluster_name    = "${var.project_name}-cluster-${var.env}"
  cluster_version = "1.24"


  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id                                     = var.vpc_id
  subnet_ids                                 = var.vpc_private_subnet_ids
  cluster_endpoint_public_access_cidrs       = ["${chomp(data.http.myipaddress.body)}/32"]
  enable_irsa                                = true
  create_cluster_primary_security_group_tags = true

  cluster_security_group_additional_rules = {
    egress_allow_access_to_nodes_aws_lb_webhook = {
      type                       = "egress"
      protocol                   = "tcp"
      from_port                  = 0
      to_port                    = 65535
      source_node_security_group = true
      description                = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }

  node_security_group_additional_rules = {

    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }

    ingress_cluster_all = {
      type                          = "ingress"
      protocol                      = "-1"
      from_port                     = 0
      to_port                       = 0
      source_cluster_security_group = true
    }

    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }


  eks_managed_node_group_defaults = {
    ami_type                              = "AL2_x86_64"
    attach_cluster_primary_security_group = false
    create_security_group                 = false
  }

  eks_managed_node_groups = {
    one = {
      name = "${var.project_name}-ng-1"

      instance_types = ["t3.large"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}

resource "aws_eks_identity_provider_config" "cluster_cognito_oidc" {
  cluster_name = module.eks.cluster_id

  oidc {
    client_id                     = var.cognito_user_pool_client_id
    identity_provider_config_name = "${var.project_name}-cognito-oidc-${var.env}"
    issuer_url                    = "https://${var.cognito_user_pool_endpoint}"
    username_claim                = "email"
    groups_claim                  = "cognito:groups"
    groups_prefix                 = "gid:"
  }
}