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
    explicit_name               = "default-waf-policy-name"
    mode                        = "Detection"
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 1024
  }

  # Neutralize managed/custom WAF rules to match existing policy and avoid diffs
  waf_managed_rules = {
    owasp_rules = []
    bot_rules   = []
    exclusions  = []
  }
  waf_custom_rules_allow_https_challenges                    = false
  waf_custom_rules_allow_monitoring_agents_to_probe_services = null
  waf_custom_rules_unique_access_to_paths_ip_restricted      = {}
  waf_custom_rules_exempted_request_path_begin_withs         = []

  tags = var.tags
}
