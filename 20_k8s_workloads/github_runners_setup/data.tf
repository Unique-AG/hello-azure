data "azurerm_resource_group" "vnet" {
  name = var.resource_group_vnet_name
}
data "azurerm_subnet" "subnet_github_runners" {
  name                 = var.vnet_name
  resource_group_name  = var.resource_group_vnet_name
  virtual_network_name = var.subnet_name
}
data "azurerm_subscription" "subscription" {
  subscription_id = var.subscription_id
}
