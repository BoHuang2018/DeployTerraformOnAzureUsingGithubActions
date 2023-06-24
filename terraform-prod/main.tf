terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.61.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }
  backend "azurerm" {
    subscription_id      = "68a1244e-a9df-43d4-8bc0-07e0973ae35b"
    resource_group_name  = "terraform_state_prod_rg" # value of AZURE_RESOURCE_GROUP_FOR_TERRAFORM_STATE in ../.env
    storage_account_name = "tfstate19015prod"        # value of AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE in ../.env
    container_name       = "tfstatebcprod"           # value of AZURE_BLOB_CONTAINER_NAME_FOR_TERRAFORM_STATE in ../.env
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  alias = "prod"
  features {}
  use_oidc = true
}

resource "azurerm_resource_group" "coop-interview-prod" {
  provider = azurerm.prod
  location = "Norway East"
  name     = "coop-interview-prod"
}

