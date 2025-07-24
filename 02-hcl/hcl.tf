terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.37.0"
    }
  }
}

#Activamente manegado por terraform
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name #Identifier
}

#Manegado por otro no por terraorm pero necesario para nuestro proyecto
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not_managed-by-us"
}

variable "bucket_name" {
  type = string
  description = "Variable para el nombre del bucket"
  default = "default_name"
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

locals {
  local_example = "Local Variable"
}

module "my_module" {
  source = "./module-example"
}