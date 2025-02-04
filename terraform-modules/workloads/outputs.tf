output "oai_model_version_endpoints_secret_name" {
  value       = module.openai.model_version_endpoint_secret_name
  description = "The secret name for the OpenAI model version endpoints."
}

output "oai_cognitive_account_endpoints_secret_names" {
  value       = module.openai.endpoints_secret_names
  description = "The secret names for the OpenAI cognitive account endpoints."
}

output "document_inteliigence_endpoint_definitions_secret_name" {
  value       = module.document_intelligence.endpoint_definitions_secret_name
  description = "The secret name for the document intelligence endpoint definitions."
}

output "document_inteliigence_endpoints_secret_name" {
  value       = module.document_intelligence.endpoints_secret_name
  description = "The secret name for the document intelligence endpoints."
}

output "aks_cluster_id" {
  value       = module.kubernetes_cluster.kubernetes_cluster_id
  description = "The ID of the AKS cluster."
}

output "psql_host_secret_name" {
  value       = module.postgresql.host_secret_name
  description = "The secret name for the PostgreSQL host."
}

output "psql_port_secret_name" {
  value       = module.postgresql.port_secret_name
  description = "The secret name for the PostgreSQL port."
}

output "psql_username_secret_name" {
  value       = module.postgresql.username_secret_name
  description = "The secret name for the PostgreSQL username."
}

output "psql_password_secret_name" {
  value       = module.postgresql.password_secret_name
  description = "The secret name for the PostgreSQL password."
}

output "psql_database_connection_strings_secret_names" {
  value       = module.postgresql.database_connection_strings_secret_name
  description = "The secret names for the PostgreSQL database connection strings."
}

output "rabbitmq_password_chat_secret_name" {
  value       = var.rabbitmq_password_chat_secret_name
  description = "The secret name for the RabbitMQ password for chat."
}

output "redis_cache_port_secret_name" {
  value       = module.redis.redis_cache_port_secret_name
  description = "The secret name for the Redis cache port."
}

output "redis_cache_host_secret_name" {
  value       = module.redis.redis_cache_host_secret_name
  description = "The secret name for the Redis cache host."
}

output "redis_cache_password_secret_name" {
  value       = module.redis.redis_cache_password_secret_name
  description = "The secret name for the Redis cache password."
}

output "ingestion_cache_connection_string_1_secret_name" {
  value       = var.ingestion_cache_connection_string_1_secret_name
  description = "The secret name for the first ingestion cache connection string."
}

output "ingestion_cache_connection_string_2_secret_name" {
  value       = var.ingestion_cache_connection_string_2_secret_name
  description = "The secret name for the second ingestion cache connection string."
}

output "ingestion_storage_connection_string_1_secret_name" {
  value       = var.ingestion_storage_connection_string_1_secret_name
  description = "The secret name for the first ingestion storage connection string."
}

output "ingestion_storage_connection_string_2_secret_name" {
  value       = var.ingestion_storage_connection_string_2_secret_name
  description = "The secret name for the second ingestion storage connection string."
}

output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "The ID of the Azure Container Registry."
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "The login server of the Azure Container Registry."
}

output "acr_name" {
  value       = azurerm_container_registry.acr.name
  description = "The name of the Azure Container Registry."
}

output "identity_principal_id" {
  value       = azurerm_container_registry.acr.identity.0.principal_id
  description = "The principal ID of the Azure Container Registry's managed identity."
}

output "encryption_key_app_repository_secret_name" {
  value       = var.encryption_key_app_repository_secret_name
  description = "The secret name for the encryption key of the app repository."
}

output "encryption_key_node_chat_lxm_secret_name" {
  value       = var.encryption_key_node_chat_lxm_secret_name
  description = "The secret name for the encryption key of the node chat LXM."
}

output "encryption_key_ingestion_secret_name" {
  value       = var.encryption_key_ingestion_secret_name
  description = "The secret name for the encryption key of the ingestion."
}

output "zitadel_db_user_password_secret_name" {
  value       = var.zitadel_db_user_password_secret_name
  description = "The secret name for the Zitadel database user password."
}

output "container_registry_url" {
  value       = azurerm_container_registry.acr.login_server
  description = "The URL of the Azure Container Registry."
}

output "zitadel_master_key_secret_name" {
  value       = var.zitadel_master_key_secret_name
  description = "The secret name for the Zitadel master key."
}

output "cluster_kublet_client_id" {
  value       = module.kubernetes_cluster.kublet_identity_client_id
  description = "The client ID of the Kubernetes cluster's kubelet identity."
}

output "cluster_kublet_object_id" {
  value       = module.kubernetes_cluster.kublet_identity_object_id
  description = "The object ID of the Kubernetes cluster's kubelet identity."
}

output "csi_user_assigned_identity_name" {
  value       = module.kubernetes_cluster.csi_user_assigned_identity_name
  description = "The name of the user-assigned identity for the CSI driver."
}

output "application_gateway_ip_address" {
  value = module.application_gateway.appgw_ip_address
}
output "application_gateway_id" {
  value = module.application_gateway.appgw_id
}
output "zitadel_pat_secret_name" {
  value = var.zitadel_pat_secret_name
}
