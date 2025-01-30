#tfsec:ignore:azure-keyvault-content-type-for-secret
#tfsec:ignore:azure-keyvault-ensure-key-expiry
module "ingestion_cache" {
  source = "github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-2.0.0"

  name                          = var.ingestion_cache_sa_name
  resource_group_name           = data.azurerm_resource_group.sensitive.name
  location                      = data.azurerm_resource_group.sensitive.location
  tags                          = var.tags
  access_tier                   = "Hot"
  deleted_retain_days           = 7
  container_deleted_retain_days = 7

  storage_management_policy_default = {
    enabled                                  = true
    blob_to_cool_after_last_modified_days    = 1
    blob_to_cold_after_last_modified_days    = 2
    blob_to_archive_after_last_modified_days = 3
    blob_to_deleted_after_last_modified_days = 5
  }

  self_cmk = {
    key_vault_id              = var.sensitive_kv_id
    key_name                  = "ingestion-cache-cmk"
    user_assigned_identity_id = var.ingestion_cache_user_assigned_identity_id
  }

  connection_settings = {
    connection_string_1 = var.ingestion_cache_connection_string_1_secret_name
    connection_string_2 = var.ingestion_cache_connection_string_2_secret_name
    key_vault_id        = var.sensitive_kv_id
  }

  identity_ids = [var.ingestion_cache_user_assigned_identity_id]
}

#tfsec:ignore:azure-keyvault-content-type-for-secret
#tfsec:ignore:azure-keyvault-ensure-key-expiry
module "ingestion_storage" {
  source = "github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-2.0.0"

  name                = var.ingestion_storage_sa_name
  resource_group_name = data.azurerm_resource_group.sensitive.name
  location            = data.azurerm_resource_group.sensitive.location
  tags                = var.tags
  access_tier         = "Hot"

  deleted_retain_days           = 7
  container_deleted_retain_days = 7

  storage_management_policy_default = {
    enabled                                  = true
    blob_to_cool_after_last_modified_days    = 7
    blob_to_cold_after_last_modified_days    = 14
    blob_to_archive_after_last_modified_days = 30
    blob_to_deleted_after_last_modified_days = 5 * 365
  }

  self_cmk = {
    key_vault_id              = var.sensitive_kv_id
    key_name                  = "ingestion-storage-cmk"
    user_assigned_identity_id = var.ingestion_storage_user_assigned_identity_id
  }

  connection_settings = {
    connection_string_1 = var.ingestion_storage_connection_string_1_secret_name
    connection_string_2 = var.ingestion_storage_connection_string_2_secret_name
    key_vault_id        = var.sensitive_kv_id
  }

  identity_ids = [var.ingestion_storage_user_assigned_identity_id]
}
