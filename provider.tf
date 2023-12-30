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
  access_key = "AKIAZNCPHAXR5WDDJXSL"
  secret_key = "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"
}