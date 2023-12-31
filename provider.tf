terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}
provider "aws" {
  region     = var.region
  access_key = "AKIA42MJNDT75ALQTLCU"
  secret_key = "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"
}
