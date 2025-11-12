data "azuread_service_principal" "terraform" {
  client_id = var.client_id
}

# Conditional data source: only read cluster if cluster_id is provided and non-empty
# This allows bootstrap scenarios where the cluster doesn't exist yet
# Note: If var.cluster_id is unknown (from module output), Terraform will evaluate this during apply
# If the cluster doesn't exist, the data source will fail, which is expected during bootstrap
data "azurerm_kubernetes_cluster" "cluster" {
  count               = try(length(var.cluster_id) > 0, false) ? 1 : 0
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
