# In theory shouldn't be needed in v3.115 (https://github.com/hashicorp/terraform-provider-azurerm/pull/26899)
resource "azurerm_resource_provider_registration" "azure_dashboard_provider" {
  name = "Microsoft.Dashboard"
}

resource "azurerm_resource_provider_registration" "azure_monitor_provider" {
  name = "Microsoft.Monitor"
}

resource "azurerm_resource_provider_registration" "azure_alerts_provider" {
  name = "Microsoft.AlertsManagement"
}
