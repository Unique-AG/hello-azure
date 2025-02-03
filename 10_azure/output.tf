output "resource_group_core_name" {
  value       = module.identities.resource_group_core_name
  description = "The name of the core resource group."
}
output "oai_model_version_endpoints_secret_name" {
  value       = module.workloads.oai_model_version_endpoints_secret_name
  description = "The secret name for OAI model version endpoints."
}
output "oai_cognitive_account_endpoints_secret_names" {
  value       = module.workloads.oai_cognitive_account_endpoints_secret_names
  description = "The secret names for OAI cognitive account endpoints."
}
output "document_inteliigence_endpoint_definitions_secret_name" {
  value       = module.workloads.document_inteliigence_endpoint_definitions_secret_name
  description = "The secret name for document intelligence endpoint definitions."
}
output "document_inteliigence_endpoints_secret_name" {
  value       = module.workloads.document_inteliigence_endpoints_secret_name
  description = "The secret name for document intelligence endpoints."
}

output "aks_cluster_id" {
  value       = module.workloads.aks_cluster_id
  description = "The ID of the AKS cluster."
}

output "psql_host_secret_name" {
  value       = module.workloads.psql_host_secret_name
  description = "The secret name for PostgreSQL host."
}
output "psql_port_secret_name" {
  value       = module.workloads.psql_port_secret_name
  description = "The secret name for PostgreSQL port."
}
output "psql_username_secret_name" {
  value       = module.workloads.psql_username_secret_name
  description = "The secret name for PostgreSQL username."
}
output "psql_password_secret_name" {
  value       = module.workloads.psql_password_secret_name
  description = "The secret name for PostgreSQL password."
}
output "psql_database_connection_strings_secret_names" {
  value       = module.workloads.psql_database_connection_strings_secret_names
  description = "The secret names for PostgreSQL database connection strings."
}

output "rabbitmq_password_chat_secret_name" {
  value       = module.workloads.rabbitmq_password_chat_secret_name
  description = "The secret name for RabbitMQ password for chat."
}

output "redis_cache_port_secret_name" {
  value       = module.workloads.redis_cache_port_secret_name
  description = "The secret name for Redis cache port."
}
output "redis_cache_host_secret_name" {
  value       = module.workloads.redis_cache_host_secret_name
  description = "The secret name for Redis cache host."
}
output "redis_cache_password_secret_name" {
  value       = module.workloads.redis_cache_password_secret_name
  description = "The secret name for Redis cache password."
}

output "ingestion_cache_connection_string_1_secret_name" {
  value       = module.workloads.ingestion_cache_connection_string_1_secret_name
  description = "The secret name for ingestion cache connection string 1."
}
output "ingestion_cache_connection_string_2_secret_name" {
  value       = module.workloads.ingestion_cache_connection_string_2_secret_name
  description = "The secret name for ingestion cache connection string 2."
}
output "ingestion_storage_connection_string_1_secret_name" {
  value       = module.workloads.ingestion_storage_connection_string_1_secret_name
  description = "The secret name for ingestion storage connection string 1."
}
output "ingestion_storage_connection_string_2_secret_name" {
  value       = module.workloads.ingestion_storage_connection_string_2_secret_name
  description = "The secret name for ingestion storage connection string 2."
}

output "acr_id" {
  value       = module.workloads.acr_id
  description = "The ID of the Azure Container Registry."
}
output "acr_login_server" {
  value       = module.workloads.acr_login_server
  description = "The login server of the Azure Container Registry."
}
output "acr_name" {
  value       = module.workloads.acr_name
  description = "The name of the Azure Container Registry."
}
output "identity_principal_id" {
  value       = module.workloads.identity_principal_id
  description = "The principal ID of the identity."
}

output "encryption_key_app_repository_secret_name" {
  value       = module.workloads.encryption_key_app_repository_secret_name
  description = "The secret name for the encryption key of the app repository."
}

output "encryption_key_node_chat_lxm_secret_name" {
  value       = module.workloads.encryption_key_node_chat_lxm_secret_name
  description = "The secret name for the encryption key of the node chat LXM."
}

output "encryption_key_ingestion_secret_name" {
  value       = module.workloads.encryption_key_ingestion_secret_name
  description = "The secret name for the encryption key of ingestion."
}

output "zitadel_db_user_password_secret_name" {
  value       = module.workloads.zitadel_db_user_password_secret_name
  description = "The secret name for the Zitadel database user password."
}

output "sensitive_keyvault_name" {
  value       = module.perimeter.key_vault_sensitive_name
  description = "The name of the sensitive Key Vault."
}

output "main_keyvault_name" {
  value       = module.perimeter.key_vault_main_name
  description = "The name of the main Key Vault."
}
output "container_registry_url" {
  value       = module.workloads.container_registry_url
  description = "The URL of the container registry."
}
output "zitadel_master_key_secret_name" {
  value       = module.workloads.zitadel_master_key_secret_name
  description = "The secret name for the Zitadel master key."
}
output "aks_workload_identity_client_id" {
  value       = module.identities.aks_workload_identity_client_id
  description = "The client ID of the AKS workload identity."
}
output "cluster_kublet_client_id" {
  value       = module.workloads.cluster_kublet_client_id
  description = "The client ID of the cluster kubelet."
}
output "key_vault_secrets_provider_client_id" {
  value       = module.identities.key_vault_secrets_provider_client_id
  description = "The client ID of the Key Vault secrets provider."
}
output "dns_zone_name_servers" {
  description = "The Name Servers for the DNS zone"
  value       = module.perimeter.dns_zone_name_servers
}
output "dns_zone_name" {
  description = "Name of the DNS zone"
  value       = module.perimeter.dns_zone_name
}
output "zitadel_pat_secret_name" {
  description = "Name of the manual secret containing Zitadel PAT"
  value       = module.workloads.zitadel_pat_secret_name
}
output "vnet" {
  description = "The virtual network details."
  value = {
    id   = azurerm_virtual_network.vnet.resource_id
    name = azurerm_virtual_network.vnet.name
  }
}
output "subnets" {
  description = "The subnets in the virtual network."
  value       = module.vnet.subnets
}
