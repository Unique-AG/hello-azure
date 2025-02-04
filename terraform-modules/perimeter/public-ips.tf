resource "azurerm_public_ip" "aks_public_ip" {
  name                = var.aks_public_ip_name
  sku                 = "Standard"
  location            = var.resource_group_core_location
  resource_group_name = var.resource_group_core_name
  allocation_method   = "Static"
}
