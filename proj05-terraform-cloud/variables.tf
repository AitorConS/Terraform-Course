variable "terraform-cloud-hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "Terraform cloud hostname without htpps://"
}

variable "terraform-audience" {
  type        = string
  default     = "aws.workload.identity"
  description = "Terraform cloud audience used to authenticate in AWS"
}