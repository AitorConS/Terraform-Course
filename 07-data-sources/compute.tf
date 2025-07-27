data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # Canonical (Ubuntu)
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# Conseguir ID del usuario
data "aws_caller_identity" "current" {}
#Conseguir region
data "aws_region" "current" {}
#Conseguir valores de vpc no gestionada por Terraform
data "aws_vpc" "prod_vpc" {
  tags = {
    Env = "Prod"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}


output "azs" {
  value = data.aws_availability_zones.available[*].id
}

output "aws_prod_vpc" {
  value = data.aws_vpc.prod_vpc.id
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}
output "aws_region" {
  value = data.aws_region.current
}

output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}


resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}



