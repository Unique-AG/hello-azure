module "identities" {
  source                              = "./modules/identities"
  cluster_id                          = module.workloads.aks_cluster_id
  cluster_name                        = "aks-cluster"
  psql_user_assigned_identity_name    = "psql-identity"
  aks_user_assigned_identity_name     = "aks-identity"
  sensitive_kv_id                     = module.perimeter.key_vault_sensitive_id
  main_kv_id                          = module.perimeter.key_vault_main_id
  cluster_admins                      = ["4b89a1f0-8038-4929-81e6-6d128dac7aa0", "084a1c45-5010-4aab-bab6-7b86a9d10e5c", "3b48f167-cb68-4655-b45b-878e170af84d"]
  main_keyvault_secret_writers        = ["4b89a1f0-8038-4929-81e6-6d128dac7aa0", "084a1c45-5010-4aab-bab6-7b86a9d10e5c", "3b48f167-cb68-4655-b45b-878e170af84d"]
  telemetry_observers                 = ["4b89a1f0-8038-4929-81e6-6d128dac7aa0", "084a1c45-5010-4aab-bab6-7b86a9d10e5c", "3b48f167-cb68-4655-b45b-878e170af84d"]
  client_id                           = var.client_id
  ingestion_cache_identity_name       = "ingestion-cache-identity"
  ingestion_storage_identity_name     = "ingestion-storage-identity"
  document_intelligence_identity_name = "document-intelligence-identity"
  application_gateway_id              = module.workloads.application_gateway_id
  dns_zone_id                         = module.perimeter.dns_zone_id
}
module "perimeter" {
  source                        = "./modules/perimeter"
  resource_group_vnet_name      = module.identities.resource_group_vnet_name
  resource_group_sensitive_name = module.identities.resource_group_sensitive_name
  resource_group_core_name      = module.identities.resource_group_core_name
  dns_zone_name                 = "hello.azure.unique.dev"
  tags = {
    app = "hello-azure"
  }
  dns_zone_root_records = [module.workloads.application_gateway_ip_address]
  dns_zone_sub_domain_records = {
    zitadel = {
      name    = "id"
      records = [module.workloads.application_gateway_ip_address]
    }
    argo = {
      name    = "argo"
      records = [module.workloads.application_gateway_ip_address]
    }
    api = {
      name    = "api"
      records = [module.workloads.application_gateway_ip_address]
    }
  }
  csi_identity_name               = "csi_identity"
  budget_contact_emails           = ["support@unique.ch"]
  aks_node_rg_name                = module.identities.resource_group_core_name
  sensitive_kv_name               = "helloazuresensitivekv"
  main_kv_name                    = "helloazuremainkv"
  vnet_name                       = "vnet"
  client_id                       = var.client_id
  subnet_aks_nodes_name           = "subnet_aks"
  subnet_application_gateway_name = "subnet_application_gateway"
  subnet_cognitive_services_name  = "subnet_cognitive_services"
  subnet_key_vault_name           = "subnet_key_vault"
  kv_sku                          = "premium"
  subnet_psql_name                = "subnet_psql"
  subnet_redis_name               = "subnet_redis"
  subnet_storage_name             = "subnet_storage"
  log_analytics_workspace_name    = "loganalytics"
  depends_on = [
    module.identities.resource_group_core_id,
    module.identities.resource_group_sensitive_id,
    module.identities.resource_group_vnet_id
  ]
}


module "workloads" {
  source                        = "./modules/workloads"
  postgresql_server_name        = "hello-azure-psql"
  resource_group_sensitive_name = module.identities.resource_group_sensitive_name
  resource_group_core_name      = module.identities.resource_group_core_name
  tags = {
    app = "hello-azure"
  }
  postgresql_subnet_id                            = module.perimeter.postgresql_subnet_id
  log_analytics_workspace_id                      = "/subscriptions/${var.subscription_id}/resourceGroups/${module.identities.resource_group_core_name}/providers/Microsoft.OperationalInsights/workspaces/loganalytics"
  subnet_agw_id                                   = module.perimeter.subnet_agw_id
  subnet_aks_nodes_id                             = module.perimeter.subnet_aks_nodes_id
  aks_public_ip_id                                = module.perimeter.aks_public_ip_id
  postgresql_private_dns_zone_id                  = module.perimeter.postgresql_private_dns_zone_id
  node_resource_group_name                        = "${module.identities.resource_group_core_name}-aks-nodes"
  tenant_id                                       = var.tenant_id
  cluster_name                                    = "aks-cluster"
  sensitive_kv_id                                 = module.perimeter.key_vault_sensitive_id
  main_kv_id                                      = module.perimeter.key_vault_main_id
  psql_user_assigned_identity_id                  = module.identities.psql_user_assigned_identity_id
  ingestion_cache_user_assigned_identity_id       = module.identities.ingestion_cache_user_assigned_identity_id
  ingestion_storage_user_assigned_identity_id     = module.identities.ingestion_storage_user_assigned_identity_id
  document_intelligence_user_assigned_identity_id = module.identities.document_intelligence_user_assigned_identity_id
  depends_on = [
    module.identities.resource_group_core_id,
    module.identities.resource_group_sensitive_id,
    module.identities.resource_group_vnet_id,
    module.perimeter.log_analytics_workspace_id
  ]
}
