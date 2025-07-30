locals {
  name = "Aitor Conesa"
  age = -15
  my_object = {
    key1 = 10
    key2 = 20 
  }
}


output "example-1" {
  value = startswith(lower(local.name), "aitor")
}

output "example2" {
  value = pow(local.age, 2)
}

output "example3" {
  value = yamldecode(file("${path.module}/user.yaml")).users[*].name
}

output "example4" {
  value = jsonencode(local.my_object)
}