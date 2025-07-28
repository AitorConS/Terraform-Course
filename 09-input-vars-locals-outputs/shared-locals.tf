locals {
  project = "08-inputs-vars-locals-outputs"
  project_owner = "terraform_course"
  cost_center   = "1234"
  ManagedBy     = "Terraform"
}

locals {
  common_tags = {
    project = local.project
    project_owner = local.project_owner
    cost_center   = local.cost_center
    ManagedBy     = local.ManagedBy
  }
}