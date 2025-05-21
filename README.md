# Azure Data Lakehouse with Databricks & Terraform

This project sets up a complete modular infrastructure for an Azure-based data lakehouse architecture using Terraform and Azure Databricks with Unity Catalog.

## 🏗️ Infrastructure Components

- Resource Group
- Storage Account with containers: `bronze`, `silver`, `gold`
- Azure Databricks Workspace (Premium tier)
- Access Connector for Unity Catalog
- Storage Credential using Azure Managed Identity
- External Locations in Unity Catalog

## 📁 Folder Structure

```
azure-data-engineer/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── modules/
│   ├── resource_group/
│   ├── storage_account/
│   ├── databricks_workspace/
│   ├── databricks_access_connector/
│   ├── databricks_external_credential/
│   └── databricks_external_location/
```

## 🚀 Usage

### 1. Configure Variables

Create a `terraform.tfvars` file:

```hcl
resource_group_name   = "datalake-db"
storage_account_name  = "YOUR_STORAGE_ACCOUNT_NAME"
location              = "eastus"
```

> ⚠️ `storage_account_name` must be globally unique and lowercase.

### 2. Set Azure Subscription

```bash
$env:ARM_SUBSCRIPTION_ID = "<your-subscription-id>"   
```

### 3. Login and Set Subscription

```bash
az login
az account set --subscription "<your-subscription-id>"
```

### 4. Initialize and Apply

```bash
terraform init
terraform plan
terraform apply
```

## 🔧 Post-Deploy Manual Step

1. Launch the Databricks workspace from the Azure Portal
2. Go to Catalog → ⚙️ → Metastore
3. Add yourself as a **Metastore Admin**
4. Re-run `terraform apply` to finish external credential creation

## 🧼 Destroy

```bash
terraform destroy
```

> ⚠️ Deleting a Databricks workspace may take 5–10 minutes.

## ✅ Requirements

- Terraform >= 1.3
- Azure CLI
- Azure subscription with Contributor role

