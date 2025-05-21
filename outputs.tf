output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "databricks_workspace_url" {
  value = "https://${module.databricks_workspace.name}.azuredatabricks.net"
}
