
variable "vpc_config" {
  type = object({
    cidr_block = string
    name = string
  })
  
  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config must contain a valid cidr block "
  }
}