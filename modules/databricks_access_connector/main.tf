resource "azurerm_databricks_access_connector" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type = "SystemAssigned"
  }
}
