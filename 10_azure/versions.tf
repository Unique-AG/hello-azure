terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.14.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.2.0"
    }
  }
}
