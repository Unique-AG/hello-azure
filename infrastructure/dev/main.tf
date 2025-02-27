# Local values that are computed or combined from variables
locals {

  # Dynamic DNS records
  dns_subdomain_records_with_ip = {
    for k, v in var.dns_subdomain_records : k => {
      name    = v.name
      records = [module.workloads.application_gateway_ip_address]
    }
  }
}

module "identities" {
  source = "../../terraform-modules/identities"

  aks_user_assigned_identity_name              = var.aks_identity_name
  application_gateway_id                       = module.workloads.application_gateway_id
  application_registration_gitops_display_name = var.gitops_display_name
  application_secret_display_name              = "${var.name_prefix}-gitops"
  client_id                                    = var.client_id
  cluster_admins                               = var.cluster_admin_user_ids
  cluster_id                                   = module.workloads.aks_cluster_id
  cluster_name                                 = var.cluster_name
  dns_zone_id                                  = module.perimeter.dns_zone_id
  dns_zone_name                                = var.dns_zone_name
  document_intelligence_identity_name          = var.document_intelligence_identity_name
  gitops_maintainers                           = var.gitops_maintainer_user_ids
  ingestion_cache_identity_name                = var.ingestion_cache_identity_name
  ingestion_storage_identity_name              = var.ingestion_storage_identity_name
  main_keyvault_secret_writers                 = var.keyvault_secret_writer_user_ids
  main_kv_id                                   = module.perimeter.key_vault_main_id
  psql_user_assigned_identity_name             = var.psql_identity_name
  resource_audit_location                      = var.resource_audit_location
  resource_group_core_location                 = var.resource_group_core_location
  resource_group_sensitive_location            = var.resource_group_sensitive_location
  resource_group_vnet_id                       = azurerm_resource_group.vnet.id
  resource_vnet_location                       = var.resource_vnet_location
  sensitive_kv_id                              = module.perimeter.key_vault_sensitive_id
  telemetry_observers                          = var.telemetry_observer_user_ids
}

module "perimeter" {
  source = "../../terraform-modules/perimeter"

  aks_node_rg_name              = module.identities.resource_group_core_name
  budget_contact_emails         = var.budget_contact_emails
  client_id                     = var.client_id
  csi_identity_name             = var.csi_identity_name
  dns_zone_name                 = var.dns_zone_name
  dns_zone_root_records         = [module.workloads.application_gateway_ip_address]
  dns_zone_sub_domain_records   = local.dns_subdomain_records_with_ip
  kv_sku                        = var.kv_sku
  log_analytics_workspace_name  = var.log_analytics_workspace_name
  main_kv_name                  = var.main_kv_name
  resource_group_core_location  = var.resource_group_core_location
  resource_group_core_name      = module.identities.resource_group_core_name
  resource_group_sensitive_name = module.identities.resource_group_sensitive_name
  resource_group_vnet_name      = azurerm_resource_group.vnet.name
  sensitive_kv_name             = var.sensitive_kv_name
  tags                          = var.tags
  virtual_network_id            = module.vnet.resource_id
  
  depends_on = [
    module.identities.resource_group_core_id,
    module.identities.resource_group_sensitive_id,
    # module.identities.resource_group_vnet_id
  ]
}

module "workloads" {
  source = "../../terraform-modules/workloads"

  aks_public_ip_id                               = module.perimeter.aks_public_ip_id
  cluster_name                                   = var.cluster_name
  custom_subdomain_name                          = var.custom_subdomain_name
  document_intelligence_user_assigned_identity_id = module.identities.document_intelligence_user_assigned_identity_id
  ingestion_cache_user_assigned_identity_id      = module.identities.ingestion_cache_user_assigned_identity_id
  ingestion_storage_user_assigned_identity_id    = module.identities.ingestion_storage_user_assigned_identity_id
  log_analytics_workspace_id                     = "/subscriptions/${var.subscription_id}/resourceGroups/${module.identities.resource_group_core_name}/providers/Microsoft.OperationalInsights/workspaces/${module.perimeter.log_analytics_workspace_name}"
  main_kv_id                                     = "/subscriptions/${var.subscription_id}/resourceGroups/${module.identities.resource_group_core_name}/providers/Microsoft.KeyVault/vaults/${module.perimeter.key_vault_main_name}"
  name_prefix                                    = var.name_prefix
  node_resource_group_name                       = "${module.identities.resource_group_core_name}-aks-nodes"
  postgresql_private_dns_zone_id                 = module.perimeter.postgresql_private_dns_zone_id
  postgresql_server_name                         = "${var.name_prefix}-psql"
  postgresql_subnet_id                           = module.vnet.subnets["snet-psql"].resource_id
  psql_user_assigned_identity_id                 = module.identities.psql_user_assigned_identity_id
  resource_group_core_location                   = var.resource_group_core_location
  resource_group_core_name                       = module.identities.resource_group_core_name
  resource_group_sensitive_name                  = module.identities.resource_group_sensitive_name
  sensitive_kv_id                                = module.perimeter.key_vault_sensitive_id
  subnet_agw_cidr                                = var.subnet_agw_cidr
  subnet_agw_id                                  = module.vnet.subnets["snet-agw"].resource_id
  subnet_aks_nodes_id                            = module.vnet.subnets["snet-aks-nodes"].resource_id
  tags                                           = var.tags
  tenant_id                                      = var.tenant_id
  
  depends_on = [
    module.identities.resource_group_core_id,
    module.identities.resource_group_sensitive_id,
    module.perimeter.key_vault_main_id,
    module.perimeter.key_vault_sensitive_id
    # module.identities.resource_group_vnet_id,
    # module.perimeter.log_analytics_workspace_id
  ]
}
