module "application_gateway" {
  source                     = "github.com/Unique-AG/terraform-modules.git//modules/azure-application-gateway?ref=feat/added-public-ip-configuration-on-app-gw-module"
  tags                       = var.tags
  name_prefix                = var.name_prefix
  resource_group_name        = data.azurerm_resource_group.core.name
  resource_group_location    = data.azurerm_resource_group.core.location
  subnet_appgw               = var.subnet_agw_id
  gateway_mode               = "Detection"
  gateway_sku                = "WAF_v2"
  gateway_tier               = "WAF_v2"
  private_ip                 = cidrhost(var.subnet_agw_cidr, 6)
  log_analytics_workspace_id = var.log_analytics_workspace_id
  ip_name                    = var.ip_name
  public_ip_enabled          = false # FIXME: revert to using public IP once confirmed that using private IP alone is enough
}
