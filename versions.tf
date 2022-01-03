terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
  access_key = "AKIAWWBDGIQLJ67O75E6"
  secret_key = "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"
}