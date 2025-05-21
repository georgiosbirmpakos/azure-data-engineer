resource "azurerm_role_assignment" "this" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.principal_id
}
