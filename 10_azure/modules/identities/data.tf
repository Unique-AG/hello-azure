data "azuread_service_principal" "terraform" {
  client_id = var.client_id
}

data "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.core.name
}


data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

data "azurerm_role_definition" "reader" {
  name = "Reader"
}

data "azurerm_role_definition" "grafana_viewer" {
  name = "Grafana Viewer"
}

data "azurerm_subscription" "current" {
}
data "azurerm_role_definition" "acr_pull" {
  name = "AcrPull"
}
data "azuread_user" "cluster_admin" {
  for_each  = var.cluster_admins
  object_id = each.key
}

data "azuread_user" "main_keyvault_secret_writer" {
  for_each  = var.main_keyvault_secret_writers
  object_id = each.key
}

data "azuread_user" "telemetry_observer" {
  for_each  = var.telemetry_observers
  object_id = each.key
}
data "azuread_user" "gitops_maintainer" {
  for_each  = var.gitops_maintainers
  object_id = each.key
}


data "azuread_client_config" "current" {}

data "azuread_application_published_app_ids" "well_known" {}
