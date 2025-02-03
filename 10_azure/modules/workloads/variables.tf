variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}

variable "resource_group_sensitive_name" {
  description = "The sensitive resource group name."
  type        = string
}

variable "resource_group_core_name" {
  description = "The core resource group name."
  type        = string
}
variable "resource_group_core_location" {
  description = "The core resource group location."
  type        = string
  default     = "westeurope" # switzerlandnorth is not supported for Azure Monitor
}

variable "psql_user_assigned_identity_id" {
  description = "The ID of the PostgreSQL user-assigned identity."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure subscription."
  type        = string

  validation {
    condition     = length(var.tenant_id) > 0
    error_message = "The tenant ID must not be empty."
  }
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  type        = string
}

variable "subnet_agw_id" {
  description = "The ID of the application gateway subnet."
  type        = string
}

variable "subnet_aks_nodes_id" {
  description = "The ID of the AKS nodes subnet."
  type        = string
}

variable "aks_public_ip_id" {
  description = "The ID of the AKS public IP."
  type        = string
}

variable "node_resource_group_name" {
  description = "The name of the resource group for AKS nodes."
  type        = string
}

variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "sensitive_kv_id" {
  description = "The ID of the sensitive key vault."
  type        = string
}
variable "postgresql_subnet_id" {
  description = "ID of the subnet dedicated to the PostgreSQL"
  type        = string
}

variable "main_kv_id" {
  description = "The ID of the main key vault."
  type        = string
}

variable "ingestion_cache_user_assigned_identity_id" {
  description = "The ID of the ingestion cache user-assigned identity."
  type        = string
}

variable "ingestion_storage_user_assigned_identity_id" {
  description = "The ID of the ingestion storage user-assigned identity."
  type        = string
}

variable "document_intelligence_user_assigned_identity_id" {
  description = "The ID of the document intelligence user-assigned identity."
  type        = string
}

variable "rabbitmq_password_chat_secret_name" {
  type        = string
  description = "The name of the secret containing the rabbitmq password."
  default     = "rabbitmq-password-chat"
}

variable "ingestion_cache_connection_string_1_secret_name" {
  type    = string
  default = "ingestion-cache-connection-string-1"
}
variable "ingestion_cache_connection_string_2_secret_name" {
  type    = string
  default = "ingestion-cache-connection-string-2"
}
variable "ingestion_storage_connection_string_1_secret_name" {
  type    = string
  default = "ingestion-storage-connection-string-1"
}
variable "ingestion_storage_connection_string_2_secret_name" {
  type    = string
  default = "ingestion-storage-connection-string-2"
}

variable "encryption_key_app_repository_secret_name" {
  type    = string
  default = "encryption-key-app-repository"
}

variable "encryption_key_node_chat_lxm_secret_name" {
  type    = string
  default = "encryption-key-chat-lxm"
}

variable "encryption_key_ingestion_secret_name" {
  type    = string
  default = "encryption-key-ingestion"
}

variable "zitadel_db_user_password_secret_name" {
  type    = string
  default = "zitadel-db-user-password"
}

variable "zitadel_master_key_secret_name" {
  type    = string
  default = "zitadel-master-key"
}

variable "container_registry_name" {
  type    = string
  default = "uniquehelloazure"
}
variable "registry_diagnostic_name" {
  type    = string
  default = "log-helloazure"
}
variable "custom_subdomain_name" {
  type    = string
  default = "hello-azure-unique-dev"
}
variable "redis_name" {
  type    = string
  default = "uniquehelloazureredis"
}
variable "ingestion_cache_sa_name" {
  type    = string
  default = "helloazureingcache"
}
variable "ingestion_storage_sa_name" {
  type    = string
  default = "helloazureingstorage"
}
variable "postgresql_private_dns_zone_id" {
  type = string
}
variable "name_prefix" {
  description = "Prefix for the name of the Application Gateway"
  type        = string
  default     = "agw_"
}

variable "ip_name" {
  description = "Name of the public IP for the Application Gateway"
  type        = string
  default     = "default-public-ip-name"
}


variable "zitadel_pat_secret_name" {
  description = "Name of the empty secret placeholder for the Zitadel PAT to be created for manually setting the value later"
  type        = string
  default     = "manual-zitadel-scope-mgmt-pat"
}
