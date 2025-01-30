module "application_gateway" {
  source                     = "github.com/Unique-AG/terraform-modules.git//modules/azure-application-gateway?ref=azure-application-gateway-2.0.0-rc.1"
  tags                       = var.tags
  name_prefix                = var.name_prefix
  resource_group_name        = data.azurerm_resource_group.core.name
  resource_group_location    = data.azurerm_resource_group.core.location
  subnet_appgw               = var.subnet_agw_id
  gateway_sku                = "WAF_v2"
  gateway_tier               = "WAF_v2"
  private_ip                 = cidrhost("10.0.5.0/24", 6)
  log_analytics_workspace_id = var.log_analytics_workspace_id
  ip_name                    = var.ip_name
}
