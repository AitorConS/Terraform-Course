terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  region = "us-west-1"
  alias = "us-east"
}

resource "aws_s3_bucket" "EU" {
  bucket = "amazing-aitor-bucket-magical"
}

resource "aws_s3_bucket" "US" {     
  bucket = "amazing-aitor-bucket-aesadsdadsadad"
  provider = aws.us-east
}