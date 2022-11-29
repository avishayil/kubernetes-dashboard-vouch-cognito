provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes {
    host                   = module.cloud.cluster_endpoint
    cluster_ca_certificate = base64decode(module.cloud.cluster_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.cloud.cluster_name]
      command     = "aws"
    }
  }
}

provider "kubernetes" {
  host                   = module.cloud.cluster_endpoint
  cluster_ca_certificate = base64decode(module.cloud.cluster_ca_certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.cloud.cluster_name]
    command     = "aws"
  }
}