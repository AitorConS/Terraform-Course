locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
  }
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

#FROM COUNT
resource "aws_instance" "from_count" {
  count         = var.ec2_instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id

  tags = {
    Name    = "${local.project}-${count.index}"
    Project = local.project
  }
}

#FROM LIST
resource "aws_instance" "from_list" {
  count      = length(var.ec2_instance_config_list)
  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id

  tags = {
    Name    = "${local.project}-${count.index}"
    Project = local.project
  }
}
