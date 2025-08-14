data "azurerm_public_ip" "application_gateway_public_ip" {
  name                = var.ip_name
  resource_group_name = var.resource_group_core_name
}

module "application_gateway" {
  source = "github.com/Unique-AG/terraform-modules.git//modules/azure-application-gateway?ref=azure-application-gateway-4.0.0-rc.2"

  name_prefix = var.name_prefix

  resource_group = {
    name     = data.azurerm_resource_group.core.name
    location = data.azurerm_resource_group.core.location
  }

  # Keep WAF policy managed (avoid count=0 -> destroy) by ensuring WAF_v2 SKU
  sku = {
    name = "WAF_v2"
    tier = "WAF_v2"
  }

  gateway_ip_configuration = {
    name               = "gateway-ip-configuration"
    subnet_resource_id = var.subnet_agw_id
  }

  public_frontend_ip_configuration = {
    name                   = data.azurerm_public_ip.application_gateway_public_ip.name
    ip_address_resource_id = data.azurerm_public_ip.application_gateway_public_ip.id
  }

  # Preserve existing WAF policy name to avoid replacement
  waf_policy_settings = {
    explicit_name = "default-waf-policy-name"
  }

  tags = var.tags
}
