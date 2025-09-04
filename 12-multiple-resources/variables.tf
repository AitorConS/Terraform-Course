variable "subnet_count" {
  type    = number
  default = 2
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

  # Ensure that only t2.micro is allowed

  validation {
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["nginx", "ubuntu"], config.ami)
    ])
    error_message = "Only ubuntu and nginx instance are allowed"
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_index  = optional(number, 0)
  }))

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["nginx", "ubuntu"], config.ami)
    ])
    error_message = "Only ubuntu and nginx instance are allowed"
  }

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["t2.micro"], config.instance_type)
    ])
    error_message = "Only t2.micro instance are allowed"
  }
}
