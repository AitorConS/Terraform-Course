variable "ec2_instance_type" {
  type        = string
  description = "The type of the managed EC2 instances."

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only t2.micro and t3.micro instances are supported."
  }
}

variable "ec2_volume_conf" {
  type = object({
    type = string
    size = number
  })
  description = "The size and type of the root block volume for EC2 instances."
}

variable "additional_text" {
  type    = map(string)
  default = {}
}