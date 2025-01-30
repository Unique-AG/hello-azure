locals {
  key_reader_key_vault_role_name     = "Key Vault Crypto Service Encryption User"
  secret_reader_key_vault_role_name  = "Key Vault Secrets User"
  key_manager_key_vault_role_name    = "Key Vault Crypto Officer"
  secret_manager_key_vault_role_name = "Key Vault Secrets Officer"
  access_manager_key_vault_role_name = "Key Vault Data Access Administrator"
  cluster_user_role_name             = "Azure Kubernetes Service Cluster User Role"
  cluster_rbac_admin_role_name       = "Azure Kubernetes Service RBAC Cluster Admin"
}

resource "azurerm_role_assignment" "csi_identity_secret_reader_main_kv" {
  principal_id         = data.azurerm_kubernetes_cluster.cluster.key_vault_secrets_provider[0].secret_identity[0].object_id
  role_definition_name = local.secret_reader_key_vault_role_name
  scope                = var.main_kv_id
}

resource "azurerm_role_assignment" "csi_identity_secret_reader" {
  principal_id         = data.azurerm_kubernetes_cluster.cluster.key_vault_secrets_provider[0].secret_identity[0].object_id
  role_definition_name = local.secret_reader_key_vault_role_name
  scope                = var.sensitive_kv_id
}

resource "azurerm_role_assignment" "psql_identity_role_assignment" {
  principal_id         = azurerm_user_assigned_identity.psql_identity.principal_id
  role_definition_name = local.key_reader_key_vault_role_name
  scope                = var.sensitive_kv_id
}

resource "azurerm_role_assignment" "ingestion_cache_kv_key_reader" {
  principal_id         = azurerm_user_assigned_identity.ingestion_cache_identity.principal_id
  scope                = var.sensitive_kv_id
  role_definition_name = local.key_reader_key_vault_role_name
}

resource "azurerm_role_assignment" "ingestion_storage_kv_key_reader" {
  principal_id         = azurerm_user_assigned_identity.ingestion_storage_identity.principal_id
  scope                = var.sensitive_kv_id
  role_definition_name = local.key_reader_key_vault_role_name
}

resource "azurerm_role_assignment" "ingestion_cache_kv_secrets_reader" {
  principal_id         = azurerm_user_assigned_identity.ingestion_cache_identity.principal_id
  scope                = var.sensitive_kv_id
  role_definition_name = local.secret_reader_key_vault_role_name
}

resource "azurerm_role_assignment" "ingestion_storage_kv_secrets_reader" {
  principal_id         = azurerm_user_assigned_identity.ingestion_storage_identity.principal_id
  scope                = var.sensitive_kv_id
  role_definition_name = local.secret_reader_key_vault_role_name
}

# resource "azurerm_role_assignment" "ingestion_storage_system_id_kv_key_reader" {
#   principal_id         = data.azurerm_storage_account.ingestion_storage.identity[0].principal_id
#   role_definition_name = local.key_reader_key_vault_role_name
#   scope                = var.sensitive_kv_id
# }

# resource "azurerm_role_assignment" "ingestion_storage_system_id_kv_secrets_reader" {
#   principal_id         = data.azurerm_storage_account.ingestion_storage.identity[0].principal_id
#   role_definition_name = local.secret_reader_key_vault_role_name
#   scope                = var.sensitive_kv_id
# }


resource "azurerm_role_assignment" "kv_main_crypto_officer_terraform_assign" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = local.key_manager_key_vault_role_name
  scope                = var.main_kv_id
}

resource "azurerm_role_assignment" "kv_main_secrets_officer_terraform_assign" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = local.secret_manager_key_vault_role_name
  scope                = var.main_kv_id
}

resource "azurerm_role_assignment" "kv_main_access_administrator_terraform_assign" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = local.access_manager_key_vault_role_name
  scope                = var.main_kv_id
}

resource "azurerm_role_assignment" "kv_crypto_officer_terraform_assign" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = local.key_manager_key_vault_role_name
  scope                = var.sensitive_kv_id
}

resource "azurerm_role_assignment" "kv_secrets_officer_terraform_assign" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = local.secret_manager_key_vault_role_name
  scope                = var.sensitive_kv_id
}

resource "azurerm_role_assignment" "kv_access_administrator_terraform_assign" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = local.access_manager_key_vault_role_name
  scope                = var.sensitive_kv_id
}

resource "azurerm_role_assignment" "cluster_user_terraform" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = local.cluster_user_role_name
  scope                = data.azurerm_kubernetes_cluster.cluster.id
}
resource "azurerm_role_assignment" "cluster_rbac_admin_terraform" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = local.cluster_rbac_admin_role_name
  scope                = data.azurerm_kubernetes_cluster.cluster.id
}
resource "azurerm_role_assignment" "kubelet_identity_acr_puller_assignment" {
  principal_id         = data.azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  role_definition_name = azurerm_role_definition.acr_puller.name
  scope                = azurerm_resource_group.core.id
}

resource "azurerm_role_assignment" "acrpush_terraform" {
  principal_id         = data.azuread_service_principal.terraform.object_id
  role_definition_name = "AcrPush"
  scope                = azurerm_resource_group.core.id
}

resource "azurerm_role_assignment" "aks_workload_identity_cognitive_services_user" {
  scope                            = azurerm_resource_group.core.id
  role_definition_name             = "Cognitive Services User" # matches both OpenAI and Document Intelligence / FormRecognizer
  principal_id                     = azurerm_user_assigned_identity.aks_workload_identity.principal_id
  skip_service_principal_aad_check = true
}

# AGIC Identity needs at least 'Reader' access to Application Gateway's Resource Group
resource "azurerm_role_assignment" "application_gateway_ingres_controller_reader_role" {
  scope                = azurerm_resource_group.core.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_kubernetes_cluster.cluster.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

# AGIC Identity needs at least 'Contributor' access to Application Gateway
resource "azurerm_role_assignment" "application_gateway_ingres_controller_contributor_role" {
  scope                = var.application_gateway_id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_kubernetes_cluster.cluster.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

# AGIC Identity needs at least 'Read and join' access to Subnet
resource "azurerm_role_assignment" "application_gateway_ingres_controller_vnet_subnet_access" {
  scope                = azurerm_resource_group.vnet.id
  role_definition_name = azurerm_role_definition.vnet_subnet_access.name
  principal_id         = data.azurerm_kubernetes_cluster.cluster.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

#Azure Active Directory group assignments
resource "azurerm_role_assignment" "cluster_user_group" {
  principal_id         = azuread_group.admin_kubernetes_cluster.object_id
  role_definition_name = local.cluster_user_role_name
  scope                = data.azurerm_kubernetes_cluster.cluster.id
}
resource "azurerm_role_assignment" "cluster_rbac_admin_group" {
  principal_id         = azuread_group.admin_kubernetes_cluster.object_id
  role_definition_name = local.cluster_rbac_admin_role_name
  scope                = data.azurerm_kubernetes_cluster.cluster.id
}

resource "azurerm_role_assignment" "main_keyvault_secret_manager_group" {
  principal_id         = azuread_group.main_keyvault_secret_writer.object_id
  role_definition_name = local.secret_manager_key_vault_role_name
  scope                = var.main_kv_id
}

resource "azurerm_role_assignment" "telemetry_observer_group" {
  principal_id         = azuread_group.telemetry_observer.object_id
  scope                = azurerm_resource_group.core.id
  role_definition_name = azurerm_role_definition.telemetry_observer.name
}


# Having groups assignable to roles requires Azure AD Premium. As a workaround add users directly
resource "azurerm_role_assignment" "cluster_user_users" {
  for_each             = data.azuread_user.cluster_admin
  principal_id         = each.value.object_id
  role_definition_name = local.cluster_user_role_name
  scope                = data.azurerm_kubernetes_cluster.cluster.id
}

resource "azurerm_role_assignment" "cluster_rbac_admin_users" {
  for_each             = data.azuread_user.cluster_admin
  principal_id         = each.value.object_id
  role_definition_name = local.cluster_rbac_admin_role_name
  scope                = data.azurerm_kubernetes_cluster.cluster.id
}

resource "azurerm_role_assignment" "main_keyvault_key_reader_users" {
  for_each             = data.azuread_user.main_keyvault_secret_writer
  principal_id         = each.value.object_id
  role_definition_name = local.key_reader_key_vault_role_name
  scope                = var.main_kv_id
}

resource "azurerm_role_assignment" "main_keyvault_secret_manager_users" {
  for_each             = data.azuread_user.main_keyvault_secret_writer
  principal_id         = each.value.object_id
  role_definition_name = local.secret_manager_key_vault_role_name
  scope                = var.main_kv_id
}
resource "azurerm_role_assignment" "telemetry_observer_users" {
  for_each             = data.azuread_user.telemetry_observer
  principal_id         = each.value.object_id
  scope                = azurerm_resource_group.core.id
  role_definition_name = azurerm_role_definition.telemetry_observer.name
}
resource "azurerm_role_assignment" "dns_contributor" {
  scope                            = var.dns_zone_id
  role_definition_name             = "DNS Zone Contributor"
  principal_id                     = data.azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}
