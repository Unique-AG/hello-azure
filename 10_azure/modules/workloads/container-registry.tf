resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  location            = data.azurerm_resource_group.core.location
  resource_group_name = data.azurerm_resource_group.core.name
  sku                 = "Basic"
  admin_enabled       = false
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "acr_diagnostic" {
  count                      = var.log_analytics_workspace_id != null && var.log_analytics_workspace_id != "" ? 1 : 0
  name                       = var.registry_diagnostic_name
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = false
  }
}
