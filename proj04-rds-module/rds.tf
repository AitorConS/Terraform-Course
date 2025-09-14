module "database" {
  source = "./modules/rds"

  project_name = "proj04-rds-module"

  storage_size = 10

  credentials = {
    username = "dbadmin"
    password = "abc1234567?"
  }

  security_groups_ids = [
    aws_security_group.Compliant.id,
  ]

  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]

}    