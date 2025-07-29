terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

#AMI ID - eu-west-1: ami-064673ca419016c37
#AMI ID - us-east-1: ami-09ac0b140f63d3458
provider "aws" {
  region = "eu-west-1"
}
