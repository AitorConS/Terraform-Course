module "database" {
  source = "./modules/rds"

  project_name = "proj04-rds-module"

  storage_size = 10

  credentials = {
    username = "db-admin"
    password = "abc123?"
  }

  security_groups_ids = [

  ]

  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]

}