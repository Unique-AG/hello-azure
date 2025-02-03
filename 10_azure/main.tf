locals {
  resource_group_core_location = "swedencentral" # hello-azure uses swedencentral for capacity and cost reasons
}

module "identities" {
  source = "./modules/identities"

  aks_user_assigned_identity_name              = "aks-identity"
  application_gateway_id                       = module.workloads.application_gateway_id
  application_registration_gitops_display_name = "GitOps"
  application_secret_display_name              = "hello-azure-gitops"
  client_id                                    = var.client_id
  cluster_admins                               = ["4b89a1f0-8038-4929-81e6-6d128dac7aa0", "084a1c45-5010-4aab-bab6-7b86a9d10e5c", "3b48f167-cb68-4655-b45b-878e170af84d"]
  cluster_id                                   = module.workloads.aks_cluster_id
  cluster_name                                 = "aks-cluster"
  dns_zone_id                                  = module.perimeter.dns_zone_id
  dns_zone_name                                = "hello.azure.unique.dev"
  document_intelligence_identity_name          = "document-intelligence-identity"
  gitops_maintainers                           = ["4b89a1f0-8038-4929-81e6-6d128dac7aa0", "084a1c45-5010-4aab-bab6-7b86a9d10e5c", "3b48f167-cb68-4655-b45b-878e170af84d"]
  ingestion_cache_identity_name                = "ingestion-cache-identity"
  ingestion_storage_identity_name              = "ingestion-storage-identity"
  main_keyvault_secret_writers                 = ["4b89a1f0-8038-4929-81e6-6d128dac7aa0", "084a1c45-5010-4aab-bab6-7b86a9d10e5c", "3b48f167-cb68-4655-b45b-878e170af84d"]
  main_kv_id                                   = module.perimeter.key_vault_main_id
  psql_user_assigned_identity_name             = "psql-identity"
  resource_audit_location                      = "swedencentral" # hello-azure uses swedencentral for capacity and cost reasons
  resource_group_core_location                 = local.resource_group_core_location
  resource_group_sensitive_location            = "swedencentral" # hello-azure uses swedencentral for capacity and cost reasons
  resource_vnet_location                       = "swedencentral" # hello-azure uses swedencentral for capacity and cost reasons
  sensitive_kv_id                              = module.perimeter.key_vault_sensitive_id
  telemetry_observers                          = ["4b89a1f0-8038-4929-81e6-6d128dac7aa0", "084a1c45-5010-4aab-bab6-7b86a9d10e5c", "3b48f167-cb68-4655-b45b-878e170af84d"]
  resource_group_vnet_id                       = azurerm_resource_group.vnet.id
}

module "perimeter" {
  source = "./modules/perimeter"

  aks_node_rg_name      = module.identities.resource_group_core_name
  budget_contact_emails = ["support@unique.ch"]
  client_id             = var.client_id
  csi_identity_name     = "csi_identity"
  depends_on = [
    module.identities.resource_group_core_id,
    module.identities.resource_group_sensitive_id,
    # module.identities.resource_group_vnet_id
  ]
  dns_zone_name         = "hello.azure.unique.dev"
  dns_zone_root_records = [module.workloads.application_gateway_ip_address]
  dns_zone_sub_domain_records = {
    api = {
      name    = "api"
      records = [module.workloads.application_gateway_ip_address]
    }
    argo = {
      name    = "argo"
      records = [module.workloads.application_gateway_ip_address]
    }
    zitadel = {
      name    = "id"
      records = [module.workloads.application_gateway_ip_address]
    }
  }
  kv_sku                        = "premium"
  log_analytics_workspace_name  = "loganalytics"
  main_kv_name                  = "helloazuremain"
  resource_group_core_location  = local.resource_group_core_location
  resource_group_core_name      = module.identities.resource_group_core_name
  resource_group_sensitive_name = module.identities.resource_group_sensitive_name
  resource_group_vnet_name      = azurerm_resource_group.vnet.name
  sensitive_kv_name             = "helloazuresensitive"
  tags = {
    app = "hello-azure"
  }
  virtual_network_id = module.vnet.resource_id
}

module "workloads" {
  source = "./modules/workloads"

  aks_public_ip_id = module.perimeter.aks_public_ip_id
  cluster_name     = "aks-cluster"
  depends_on = [
    module.identities.resource_group_core_id,
    module.identities.resource_group_sensitive_id,
    module.perimeter.key_vault_main_id,
    module.perimeter.key_vault_sensitive_id
    # module.identities.resource_group_vnet_id,
    # module.perimeter.log_analytics_workspace_id
  ]
  document_intelligence_user_assigned_identity_id = module.identities.document_intelligence_user_assigned_identity_id
  ingestion_cache_user_assigned_identity_id       = module.identities.ingestion_cache_user_assigned_identity_id
  ingestion_storage_user_assigned_identity_id     = module.identities.ingestion_storage_user_assigned_identity_id
  log_analytics_workspace_id                      = "/subscriptions/${var.subscription_id}/resourceGroups/${module.identities.resource_group_core_name}/providers/Microsoft.OperationalInsights/workspaces/${module.perimeter.log_analytics_workspace_name}"
  main_kv_id                                      = "/subscriptions/${var.subscription_id}/resourceGroups/${module.identities.resource_group_core_name}/providers/Microsoft.KeyVault/vaults/${module.perimeter.key_vault_main_name}"
  node_resource_group_name                        = "${module.identities.resource_group_core_name}-aks-nodes"
  postgresql_private_dns_zone_id                  = module.perimeter.postgresql_private_dns_zone_id
  postgresql_server_name                          = "hello-azure-psql"
  name_prefix                                     = "hello-azure"
  custom_subdomain_name                           = "hello-azure"          
  postgresql_subnet_id                            = module.vnet.subnets["snet-psql"].resource_id
  psql_user_assigned_identity_id                  = module.identities.psql_user_assigned_identity_id
  resource_group_core_name                        = module.identities.resource_group_core_name
  resource_group_core_location                    = local.resource_group_core_location
  resource_group_sensitive_name                   = module.identities.resource_group_sensitive_name
  sensitive_kv_id                                 = module.perimeter.key_vault_sensitive_id
  subnet_agw_id                                   = module.vnet.subnets["snet-agw"].resource_id
  subnet_aks_nodes_id                             = module.vnet.subnets["snet-aks-nodes"].resource_id
  tags = {
    app = "hello-azure"
  }
  tenant_id = var.tenant_id
}
