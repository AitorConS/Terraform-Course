
###########################
# VPCs and Subnets
###########################

data "aws_vpc" "default" {
  default = true
}

resource "aws_vpc" "custom" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "proj04-custom"
  }
}

moved {
  from = aws_subnet.allowed
  to   = aws_subnet.private1
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name   = "subnet-custom-vpc-private-1"
    Access = "private"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1b"


  tags = {
    Name   = "subnet-custom-vpc-private-2"
    Access = "private"
  }
}


resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "subnet-custom-vpc-3"
  }
}


#For documentation. Not actively used
resource "aws_subnet" "not_allowed" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/24"

  tags = {
    Name = "subnet-default-vpc"
  }
}

###########################
# Security Groups ¡
###########################

# 1. Source security groups - From where traffic is allowed
# 2. Compliant security group
#   2.1 Security Group Rule
# 3. Non-compliant security group
#   3.1 Security group rule

resource "aws_security_group" "Source" {
  name        = "source-sg"
  description = "SG from wgere connections are allowed into the DB"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_security_group" "Compliant" {
  name        = "compliant-sg"
  description = "Compliant security group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id            = aws_security_group.Compliant.id
  referenced_security_group_id = aws_security_group.Source.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

resource "aws_security_group" "Non_Compliant" {
  name        = "non-compliant-sg"
  description = "Non-Compliant security group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.Non_Compliant.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
