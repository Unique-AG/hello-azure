variable "resource_group_vnet_name" {

}

variable "tags" {

}

variable "vnet_name" {

}
variable "github_org_id" {

}
variable "subscription_id" {
  description = "The UUID ID of the suscription (not the full Azure Resource ID)."
  type        = string
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
