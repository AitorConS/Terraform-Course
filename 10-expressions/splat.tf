locals {
  firstnames_from_splat = var.objects_list[*].firstname #Only Lists
  roles_from_splat = values(local.users_map2)[*].roles
  roles_from_splat_with_for = [for username, user_props in local.users_map2: user_props.roles]
  }

output "firstnames_from_splat" {
  value = local.firstnames_from_splat
}
output "roles_from_splat" {
  value = local.roles_from_splat

}

output "roles_from_splat_with_for" {
  value = local.roles_from_splat_with_for
}