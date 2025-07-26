resource "aws_instance" "web" {
  ami                         = "ami-03f32cd6a6de84d25"
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.nginx_group.id]
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  tags = merge(local.common_tags, {
    Name = "06-resources-ec2"
  })

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "nginx_group" {
  name        = "allow_nginx"
  description = "Allow nginx traffic"
  vpc_id      = aws_vpc.nginx_vpc.id

  tags = merge(local.common_tags, {
    Name = "06-resources-main"
  })
}

resource "aws_security_group_rule" "puerto-80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.nginx_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "puerto-443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.nginx_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}