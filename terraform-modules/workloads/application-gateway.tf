module "application_gateway" {
  source = "github.com/Unique-AG/terraform-modules.git//modules/azure-application-gateway?ref=azure-application-gateway-4.0.0-rc.2"

  resource_group = {
    name     = data.azurerm_resource_group.core.name
    location = data.azurerm_resource_group.core.location
  }

  gateway_ip_configuration = {
    name      = "gateway-ip-configuration"
    subnet_id = var.subnet_agw_id
  }

  public_frontend_ip_configuration = {
    name = var.ip_name
  }

  tags = var.tags
}
