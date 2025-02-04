resource "azurerm_user_assigned_identity" "psql_identity" {
  name                = var.psql_user_assigned_identity_name
  location            = azurerm_resource_group.sensitive.location
  resource_group_name = azurerm_resource_group.sensitive.name
}

resource "azurerm_user_assigned_identity" "ingestion_cache_identity" {
  name                = var.ingestion_cache_identity_name
  location            = azurerm_resource_group.sensitive.location
  resource_group_name = azurerm_resource_group.sensitive.name
}

resource "azurerm_user_assigned_identity" "ingestion_storage_identity" {
  name                = var.ingestion_storage_identity_name
  location            = azurerm_resource_group.sensitive.location
  resource_group_name = azurerm_resource_group.sensitive.name
}

resource "azurerm_user_assigned_identity" "document_intelligence_identity" {
  name                = var.document_intelligence_identity_name
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
}

resource "azurerm_user_assigned_identity" "aks_workload_identity" {
  name                = var.aks_user_assigned_identity_name
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
}
