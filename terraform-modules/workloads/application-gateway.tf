data "azurerm_public_ip" "aks_public_ip" {
  name                = split("/", var.aks_public_ip_id)[8]
  resource_group_name = split("/", var.aks_public_ip_id)[4]
}

module "application_gateway" {
  source = "github.com/Unique-AG/terraform-modules.git//modules/azure-application-gateway?ref=azure-application-gateway-4.0.0-rc.2"

  name_prefix = var.name_prefix

  resource_group = {
    name     = data.azurerm_resource_group.core.name
    location = data.azurerm_resource_group.core.location
  }

  gateway_ip_configuration = {
    name               = "gateway-ip-configuration"
    subnet_resource_id = var.subnet_agw_id
  }

  public_frontend_ip_configuration = {
    name                   = data.azurerm_public_ip.aks_public_ip.name
    ip_address_resource_id = data.azurerm_public_ip.aks_public_ip.id
  }

  tags = var.tags
}
