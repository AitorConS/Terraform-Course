/* resource "aws_instance" "web" {
  ami = "ami-04c66bbcdeb7ae2e1"
  associate_public_ip_address = true
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet.id
  root_block_device {
    delete_on_termination = true
    volume_size = 10
    volume_type = "gp3"
  }
} */