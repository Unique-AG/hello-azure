resource "azurerm_public_ip" "application_gateway_public_ip" {
  name                = var.ip_name
  resource_group_name = var.resource_group_core_name
  location            = data.azurerm_resource_group.core.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

module "application_gateway" {
  source      = "github.com/Unique-AG/terraform-modules.git//modules/azure-application-gateway?depth=1&ref=azure-application-gateway-4.4.1"
  name_prefix = var.name_prefix
  autoscale_configuration = {

    max_capacity = 2
  }

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
    name                   = azurerm_public_ip.application_gateway_public_ip.name
    ip_address_resource_id = azurerm_public_ip.application_gateway_public_ip.id
  }

  # Preserve existing WAF policy name to avoid replacement
  waf_policy_settings = {
    explicit_name               = "default-waf-policy-name"
    mode                        = "Detection"
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 1024
  }

  # Ensure diagnostics are configured so the resource is not planned for destroy (count stays = 1)
  monitor_diagnostic_setting = {
    log_analytics_workspace_id = var.log_analytics_workspace_id
    enabled_log = [
      {
        category_group = "allLogs"
      }
    ]
  }



  tags = var.tags

  depends_on = [
    azurerm_public_ip.application_gateway_public_ip
  ]
}
