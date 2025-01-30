data "azuread_service_principal" "terraform" {
  client_id = var.client_id
}

data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "vnet" {
  name = var.resource_group_vnet_name
}
data "azurerm_resource_group" "sensitive" {
  name = var.resource_group_sensitive_name
}
data "azurerm_resource_group" "core" {
  name = var.resource_group_core_name
}
