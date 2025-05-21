terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
    databricks = {
      source  = "databricks/databricks"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "storage_account" {
  source              = "./modules/storage_account"
  name                = var.storage_account_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
}

module "databricks_workspace" {
  source              = "./modules/databricks_workspace"
  name                = "datalake-db"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  sku                 = "premium"
}

module "access_connector" {
  source              = "./modules/databricks_access_connector"
  name                = "unity-catalog-access-connector"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
}

provider "databricks" {
  alias = "workspace"
  azure_workspace_resource_id = module.databricks_workspace.workspace_id
}

module "external_credential" {
  source              = "./modules/databricks_external_credential"
  credential_name     = "datalake-db"
  access_connector_id = module.access_connector.id
  providers = {
    databricks = databricks.workspace
  }
}

module "external_location_bronze" {
  source          = "./modules/databricks_external_location"
  name            = "bronze"
  url             = "abfss://bronze@${module.storage_account.name}.dfs.core.windows.net/"
  credential_name = module.external_credential.credential_name

  providers = {
    databricks = databricks.workspace
  }
}

module "external_location_silver" {
  source          = "./modules/databricks_external_location"
  name            = "silver"
  url             = "abfss://silver@${module.storage_account.name}.dfs.core.windows.net/"
  credential_name = module.external_credential.credential_name

  providers = {
    databricks = databricks.workspace
  }
}

module "external_location_gold" {
  source          = "./modules/databricks_external_location"
  name            = "gold"
  url             = "abfss://gold@${module.storage_account.name}.dfs.core.windows.net/"
  credential_name = module.external_credential.credential_name

  providers = {
    databricks = databricks.workspace
  }
}

