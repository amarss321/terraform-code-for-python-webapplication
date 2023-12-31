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
  access_key = "AKIAX752RJ5SUF4B4VO5"
  secret_key = "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"
}
