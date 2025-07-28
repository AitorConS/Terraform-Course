locals {
  ec2_instance_type = var.ec2_instance_type
}


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

resource "aws_instance" "compute" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_conf.size
    volume_type           = var.ec2_volume_conf.type
  }

  tags = merge(local.common_tags, var.additional_text, {
    ManagedBy = local.ManagedBy
  })
}