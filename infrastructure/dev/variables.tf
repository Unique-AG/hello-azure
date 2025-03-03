# Backend Configuration Variables
variable "subscription_id" {
  description = "The UUID ID of the suscription (not the full Azure Resource ID)."
  type        = string
}

variable "tenant_id" {
  description = "The ID of the tenenat"
  type        = string
}

variable "client_id" {
  description = "The client ID for OIDC"
  type        = string
}

variable "use_oidc" {
  description = "Whether to use OIDC"
  type        = bool
}

variable "resource_group_name" {
  description = "The resource group name for the tfstate."
  type        = string
}

variable "storage_account_name" {
  description = "The resource group name for the storage account name"
  type        = string
}

variable "container_name" {
  description = "The resource group name for the tfstate container name"
  type        = string
}

variable "key" {
  description = "The key for the tfstate"
  type        = string
}

# Resource Locations
variable "resource_audit_location" {
  description = "The location for resource audit resources"
  type        = string
}

variable "resource_group_core_location" {
  description = "The location for core resource group"
  type        = string
}

variable "resource_group_sensitive_location" {
  description = "The location for sensitive resource group"
  type        = string
}

variable "resource_vnet_location" {
  description = "The location for virtual network resources"
  type        = string
}

# Naming and Tagging
variable "name_prefix" {
  description = "Prefix used for naming resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

# Network Configuration
variable "subnet_agw_cidr" {
  description = "CIDR block for the Application Gateway subnet"
  type        = string
}

# DNS Configuration
variable "dns_zone_name" {
  description = "The DNS zone name for the environment"
  type        = string
}

variable "custom_subdomain_name" {
  description = "The custom subdomain name to use for the application"
  type        = string
}

variable "dns_subdomain_records" {
  description = "Map of DNS subdomain records"
  type = map(object({
    name    = string
    records = list(string)
  }))
}

# Key Vault Configuration
variable "kv_sku" {
  description = "SKU for Key Vault"
  type        = string
}

variable "main_kv_name" {
  description = "Name of the main Key Vault"
  type        = string
}

variable "sensitive_kv_name" {
  description = "Name of the sensitive key vault"
  type        = string
}

# Monitoring and Analytics
variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "budget_contact_emails" {
  description = "List of email addresses for budget notifications"
  type        = list(string)
}

# AKS Configuration
variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

# Managed Identities
variable "aks_identity_name" {
  description = "Name of the AKS user-assigned identity"
  type        = string
}

variable "document_intelligence_identity_name" {
  description = "Name of the document intelligence identity"
  type        = string
}

variable "ingestion_cache_identity_name" {
  description = "Name of the ingestion cache identity"
  type        = string
}

variable "ingestion_storage_identity_name" {
  description = "Name of the ingestion storage identity"
  type        = string
}

variable "psql_identity_name" {
  description = "Name of the PostgreSQL identity"
  type        = string
}

variable "csi_identity_name" {
  description = "Name of the CSI identity"
  type        = string
}

# GitOps Configuration
variable "gitops_display_name" {
  description = "Display name for GitOps application registration"
  type        = string
}

# Access Control
variable "cluster_admin_user_ids" {
  description = "List of user object IDs that will be granted cluster administrator permissions"
  type        = list(string)
}

variable "gitops_maintainer_user_ids" {
  description = "List of user object IDs that will be granted GitOps maintainer permissions"
  type        = list(string)
}

variable "keyvault_secret_writer_user_ids" {
  description = "List of user object IDs that will be granted permissions to write secrets to Key Vault"
  type        = list(string)
}

variable "telemetry_observer_user_ids" {
  description = "List of user object IDs that will be granted permissions to view telemetry data"
  type        = list(string)
}