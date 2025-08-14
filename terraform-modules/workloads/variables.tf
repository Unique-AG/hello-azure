variable "aks_public_ip_id" {
  description = "The ID of the AKS public IP."
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "container_registry_name" {
  type    = string
  default = "uniquehelloazure"
}

variable "custom_subdomain_name" {
  type    = string
  default = "hello-azure-unique-dev"
}

variable "document_intelligence_custom_subdomain_name" {
  type    = string
  default = "di-hello-azure-unique-dev"
}

variable "speech_service_custom_subdomain_name" {
  type    = string
  default = "ss-hello-azure-unique-dev"
}

variable "document_intelligence_user_assigned_identity_id" {
  description = "The ID of the document intelligence user-assigned identity."
  type        = string
}

variable "grafana_user_assigned_identity_id" {
  description = "The ID of the Grafana user-assigned identity."
  type        = string
}

variable "encryption_key_app_repository_secret_name" {
  type    = string
  default = "encryption-key-app-repository"
}

variable "encryption_key_ingestion_secret_name" {
  type    = string
  default = "encryption-key-ingestion"
}

variable "encryption_key_node_chat_lxm_secret_name" {
  type    = string
  default = "encryption-key-chat-lxm"
}

variable "ingestion_cache_connection_string_1_secret_name" {
  type    = string
  default = "ingestion-cache-connection-string-1"
}

variable "ingestion_cache_connection_string_2_secret_name" {
  type    = string
  default = "ingestion-cache-connection-string-2"
}

variable "ingestion_cache_sa_name" {
  type    = string
  default = "helloazureingcache"
}

variable "ingestion_cache_user_assigned_identity_id" {
  description = "The ID of the ingestion cache user-assigned identity."
  type        = string
}

variable "ingestion_storage_connection_string_1_secret_name" {
  type    = string
  default = "ingestion-storage-connection-string-1"
}

variable "ingestion_storage_connection_string_2_secret_name" {
  type    = string
  default = "ingestion-storage-connection-string-2"
}

variable "ingestion_storage_sa_name" {
  type    = string
  default = "helloazureingstorage"
}

variable "ingestion_storage_user_assigned_identity_id" {
  description = "The ID of the ingestion storage user-assigned identity."
  type        = string
}

variable "ip_name" {
  description = "Name of the public IP for the Application Gateway"
  type        = string
  default     = "default-public-ip-name"
}

variable "kubernetes_default_node_size" {
  description = "The default node size for the AKS cluster"
  type        = string
  default     = "Standard_D2s_v6"
}

variable "kubernetes_rapid_max_count" {
  description = "The maximum number of nodes for the rapid node pool"
  type        = number
  default     = 3
}

variable "kubernetes_rapid_min_count" {
  description = "The minimum number of nodes for the rapid node pool"
  type        = number
  default     = 0
}

variable "kubernetes_rapid_node_count" {
  description = "The number of nodes for the rapid node pool"
  type        = number
  default     = 0
}

variable "kubernetes_rapid_node_size" {
  description = "The rapid node pool node size for the AKS cluster"
  type        = string
  default     = "Standard_D8s_v4"
}

variable "kubernetes_steady_max_count" {
  description = "The maximum number of nodes for the steady node pool"
  type        = number
  default     = 4
}

variable "kubernetes_steady_min_count" {
  description = "The minimum number of nodes for the steady node pool"
  type        = number
  default     = 0
}

variable "kubernetes_steady_node_count" {
  description = "The number of nodes for the steady node pool"
  type        = number
  default     = 2
}

variable "kubernetes_steady_node_size" {
  description = "The steady node pool node size for the AKS cluster"
  type        = string
  default     = "Standard_D8as_v5"
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  type        = string
}

variable "defender_log_analytics_workspace_id" {
  description = "The ID of the Defender Log Analytics workspace."
  type        = string
}

variable "main_kv_id" {
  description = "The ID of the main key vault."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for the name of the Application Gateway"
  type        = string
  default     = "agw"
}

variable "node_resource_group_name" {
  description = "The name of the resource group for AKS nodes."
  type        = string
}

variable "postgresql_private_dns_zone_id" {
  type = string
}

variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "postgresql_subnet_id" {
  description = "ID of the subnet dedicated to the PostgreSQL"
  type        = string
}

variable "psql_user_assigned_identity_id" {
  description = "The ID of the PostgreSQL user-assigned identity."
  type        = string
}

variable "rabbitmq_password_chat_secret_name" {
  type        = string
  description = "The name of the secret containing the rabbitmq password."
  default     = "rabbitmq-password-chat"
}

variable "redis_name" {
  type    = string
  default = "uniquehelloazureredis"
}

variable "registry_diagnostic_name" {
  type    = string
  default = "log-helloazure"
}

variable "resource_group_core_location" {
  description = "The core resource group location."
  type        = string
  default     = "westeurope" # switzerlandnorth is not supported for Azure Monitor
}

variable "resource_group_core_name" {
  description = "The core resource group name."
  type        = string
}

variable "resource_group_sensitive_name" {
  description = "The sensitive resource group name."
  type        = string
}

variable "sensitive_kv_id" {
  description = "The ID of the sensitive key vault."
  type        = string
}

variable "subnet_agw_cidr" {
  description = "The CIDR range of the application gateway subnet."
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

variable "subnet_aks_pods_id" {
  description = "The ID of the AKS pods subnet."
  type        = string
}

variable "subnet_cognitive_services_id" {
  description = "The ID of the cognitive services subnet."
  type        = string
}
variable "vnet_id" {
  description = "The ID of the virtual network."
  type        = string
}

variable "private_dns_zone_speech_service_id" {
  description = "The ID of the private DNS zone for the speech service."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}

variable "tenant_id" {
  description = "The tenant ID for the Azure subscription."
  type        = string

  validation {
    condition     = length(var.tenant_id) > 0
    error_message = "The tenant ID must not be empty."
  }
}

variable "zitadel_db_user_password_secret_name" {
  type    = string
  default = "zitadel-db-user-password"
}

variable "zitadel_master_key_secret_name" {
  type    = string
  default = "zitadel-master-key"
}

variable "zitadel_pat_secret_name" {
  description = "Name of the empty secret placeholder for the Zitadel PAT to be created for manually setting the value later"
  type        = string
  default     = "manual-zitadel-scope-mgmt-pat"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster."
  type        = string
  default     = "1.30.10"
}

# Prometheus recording rule variables
variable "prometheus_node_recording_rules" {
  description = "Node level recording rules for Prometheus monitoring"
  type = list(object({
    enabled    = optional(bool, true)
    record     = string
    expression = string
    labels     = optional(map(string))
  }))
  default = null
}

variable "prometheus_kubernetes_recording_rules" {
  description = "Kubernetes level recording rules for Prometheus monitoring"
  type = list(object({
    enabled    = optional(bool, true)
    record     = string
    expression = string
    labels     = optional(map(string))
  }))
  default = null
}

variable "prometheus_ux_recording_rules" {
  description = "UX level recording rules for Prometheus monitoring"
  type = list(object({
    enabled    = optional(bool, true)
    record     = string
    expression = string
    labels     = optional(map(string))
  }))
  default = null
}