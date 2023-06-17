terraform {
  backend "azurerm" {
    resource_group_name = "kopicloud-tfstate-rg"
    storage_account_name = "kopicloudiactest"
    container_name = "core-tfstate"
    key = "actions.tfstate"
  }
  required_providers {
    azurerm ={
      source = "hashicorp/azurerm"
      version = "3.61.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "b17065f8-d7e8-40a4-bcd4-50281f415218"
  tenant_id = "f9cbe053-06d0-453e-9c1a-e4ca96a6ed2d"
  alias = "GisDataStaging_azurerm"
}