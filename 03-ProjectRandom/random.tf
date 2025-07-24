terraform {
    required_version = "~> 1.7"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "bucket" {
  bucket = "bucket-${random_id.bucket_suffix.hex}"
}
output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

