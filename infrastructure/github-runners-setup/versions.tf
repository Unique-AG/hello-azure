terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.14.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.2.0"
    }
  }
}
