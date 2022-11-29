terraform {
  required_version = ">= 1.3.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.2.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.7.1"
    }

  }
}