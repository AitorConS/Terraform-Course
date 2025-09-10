module "vpc" {
  source = "./modules/networking"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "14-local-modules"
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-west-1a"
    }
    subnet_2 = {
      cidr_block = "10.0.2.0/24"
      public     = true
      az         = "eu-west-1b"
    }
  }
}