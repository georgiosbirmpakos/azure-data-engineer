terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

resource "databricks_storage_credential" "this" {
  name = var.credential_name

  azure_managed_identity {
    access_connector_id = var.access_connector_id
  }

  comment = "Credential for accessing ADLS containers via Unity Catalog"
}
