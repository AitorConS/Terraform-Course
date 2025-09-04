
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "${local.project}"
    Project = local.project
  }
}

resource "aws_subnet" "main" {
  for_each   = var.subnet_config
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = each.value.cidr_block

  tags = {
    Project = local.project
    Name    = "${local.project}-${each.key}"
  }
}