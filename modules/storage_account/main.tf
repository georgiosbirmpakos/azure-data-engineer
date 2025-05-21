resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true  # Required for ADLS Gen2

  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
}


resource "azurerm_storage_container" "bronze" {
  name                  = "bronze"
  storage_account_id = azurerm_storage_account.this.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "silver" {
  name                  = "silver"
  storage_account_id = azurerm_storage_account.this.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "gold" {
  name                  = "gold"
  storage_account_id = azurerm_storage_account.this.id
  container_access_type = "private"
}
