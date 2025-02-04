data "azurerm_resource_group" "sensitive" {
  name = var.resource_group_sensitive_name
}
data "azurerm_resource_group" "core" {
  name = var.resource_group_core_name
}
data "azurerm_client_config" "current" {
}
