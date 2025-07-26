
locals {
  common_tags = {
    ManagedBy  = "Terraform"
    Project    = "06-resource"
    CostCenter = "1234"
  }
}

resource "aws_vpc" "nginx_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "06-resources"
  })
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.nginx_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = merge(local.common_tags, {
    Name = "06-resources-public"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nginx_vpc.id

  tags = merge(local.common_tags, {
    Name = "06-resources-main"
  })
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.nginx_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "06-resources-main"
  })
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}

