terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.5.3"
    }
  }
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}