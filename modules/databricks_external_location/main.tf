terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

resource "databricks_external_location" "this" {
  name = var.name
  url  = var.url
  credential_name = var.credential_name

  comment = "External location for ${var.name} container"
  skip_validation = true
}
