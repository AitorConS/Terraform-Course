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

resource "aws_instance" "this" {
  ami = data.aws_ami.ubuntu.id

  instance_type = var.ec2_instance_type

  tags = {
    name = "terraform-cloud"
  }
}