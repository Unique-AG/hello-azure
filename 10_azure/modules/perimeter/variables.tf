variable "kv_sku" {
  description = "Name of the KeyVault SKU."
  type        = string
  default     = "standard"
}

variable "resource_group_vnet_name" {
  description = "The resource group name for the vnets."
  type        = string
}

variable "resource_group_sensitive_name" {
  description = "The sensitive resource group name."
  type        = string
}

variable "resource_group_core_name" {
  description = "The core resource group name."
  type        = string
}

variable "client_id" {
  description = "The client ID for authentication."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}

variable "csi_identity_name" {
  description = "The name of the CSI identity."
  type        = string
}

variable "aks_node_rg_name" {
  description = "The name of the resource group for AKS nodes."
  type        = string
}

variable "sensitive_kv_name" {
  description = "The name of the sensitive key vault."
  type        = string
}

variable "main_kv_name" {
  description = "The name of the main key vault."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "subnet_redis_name" {
  description = "The name of the Redis subnet."
  type        = string
}

variable "subnet_storage_name" {
  description = "The name of the storage subnet."
  type        = string
}

variable "subnet_cognitive_services_name" {
  description = "The name of the cognitive services subnet."
  type        = string
}

variable "subnet_key_vault_name" {
  description = "The name of the key vault subnet."
  type        = string
}

variable "subnet_aks_nodes_name" {
  description = "The name of the AKS nodes subnet."
  type        = string
}

variable "subnet_application_gateway_name" {
  description = "The name of the application gateway subnet."
  type        = string
}

variable "subnet_psql_name" {
  description = "The name of the PostgreSQL subnet."
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace."
  type        = string
}

variable "psql_private_dns_zone_name" {
  default = "psql.postgres.database.azure.com"
  type    = string
}
variable "azurerm_private_dns_zone_virtual_network_link_name" {
  default = "PsqlVnetZone.com"
  type    = string
}

variable "budget_contact_emails" {
  type = set(string)
}
variable "subscription_budget_name" {
  default = "subscription_budget"
  type    = string
}
variable "aks_public_ip_name" {
  default = "aks_public_ip"
  type    = string
}
variable "subscription_budget_amount" {
  description = "The amount for the subscription budget"
  type        = number
  default     = 2000
}
variable "dns_zone_name" {
  description = "Name for the DNS zone"
  type        = string
}
variable "dns_zone_root_records" {
  description = "List of IP addresses for the root A record in the DNS zone"
  type        = set(string)
}

variable "dns_zone_sub_domain_records" {
  description = "Map of subdomain names to their respective A record IP addresses"
  type = map(object({
    name    = string
    records = set(string)
  }))
}
