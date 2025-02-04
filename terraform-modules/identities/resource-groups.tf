
resource "azurerm_resource_group" "core" {
  name     = var.resource_group_core_name
  location = var.resource_group_core_location
}

resource "azurerm_resource_group" "sensitive" {
  name     = var.resource_group_sensitive_name
  location = var.resource_group_sensitive_location
}
