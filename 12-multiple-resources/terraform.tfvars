ec2_instance_count = 0


ec2_instance_config_list = []


ec2_instance_config_map = {
  "ubuntu_1" = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  },
  nginx_1 = {
    instance_type = "t2.micro"
    ami           = "nginx"   
    subnet_index = 1 
  }

}