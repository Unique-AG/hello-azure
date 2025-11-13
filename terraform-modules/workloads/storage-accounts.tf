#tfsec:ignore:azure-keyvault-content-type-for-secret
#tfsec:ignore:azure-keyvault-ensure-key-expiry
module "ingestion_cache" {
  source = "github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-3.1.0"

  name                          = var.ingestion_cache_sa_name
  resource_group_name           = data.azurerm_resource_group.sensitive.name
  location                      = data.azurerm_resource_group.sensitive.location
  tags                          = var.tags
  access_tier                   = "Hot"
  account_replication_type      = "LRS"
  backup_vault                  = null
  public_network_access_enabled = true

  data_protection_settings = {
    change_feed_enabled                  = false
    change_feed_retention_days           = 0
    versioning_enabled                   = false
    container_soft_delete_retention_days = 7
    blob_soft_delete_retention_days      = 7
    point_in_time_restore_days           = -1
  }

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
  source = "github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-3.1.0"

  name                          = var.ingestion_storage_sa_name
  resource_group_name           = data.azurerm_resource_group.sensitive.name
  location                      = data.azurerm_resource_group.sensitive.location
  tags                          = var.tags
  access_tier                   = "Hot"
  account_replication_type      = "LRS"
  backup_vault                  = null
  public_network_access_enabled = true

  data_protection_settings = {
    change_feed_enabled                  = false
    change_feed_retention_days           = 0
    versioning_enabled                   = false
    container_soft_delete_retention_days = 7
    blob_soft_delete_retention_days      = 7
    point_in_time_restore_days           = -1
  }

  storage_management_policy_default = {
    enabled                                  = true
    blob_to_cool_after_last_modified_days    = 7
    blob_to_cold_after_last_modified_days    = 14
    blob_to_archive_after_last_modified_days = 99999
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

#tfsec:ignore:azure-keyvault-content-type-for-secret
#tfsec:ignore:azure-keyvault-ensure-key-expiry
module "audit_storage" {
  source = "github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-3.1.0"

  name                          = var.audit_storage_sa_name
  resource_group_name           = data.azurerm_resource_group.sensitive.name
  location                      = data.azurerm_resource_group.sensitive.location
  tags                          = var.tags
  access_tier                   = "Cool"
  account_replication_type      = "LRS"
  backup_vault                  = null
  public_network_access_enabled = true

  data_protection_settings = {
    change_feed_enabled                  = false
    change_feed_retention_days           = 0
    versioning_enabled                   = false
    container_soft_delete_retention_days = 7
    blob_soft_delete_retention_days      = 7
    point_in_time_restore_days           = -1
  }

  storage_management_policy_default = {
    enabled                                  = true
    blob_to_cool_after_last_modified_days    = 30
    blob_to_cold_after_last_modified_days    = 90
    blob_to_archive_after_last_modified_days = 180
    blob_to_deleted_after_last_modified_days = 7 * 365
  }

  self_cmk = {
    key_vault_id              = var.sensitive_kv_id
    key_name                  = "audit-storage-cmk"
    user_assigned_identity_id = var.audit_storage_user_assigned_identity_id
  }

  identity_ids = [var.audit_storage_user_assigned_identity_id]
}

# Create storage containers for audit logs
resource "azurerm_storage_container" "audit_containers" {
  for_each              = toset(var.audit_containers)
  name                  = each.value
  storage_account_name  = var.audit_storage_sa_name
  container_access_type = "private"
  depends_on            = [module.audit_storage]
}

# Create Key Vault secrets for audit storage mounting
resource "azurerm_key_vault_secret" "audit_storage_resource_group" {
  name         = var.audit_storage_resource_group_secret_name
  value        = data.azurerm_resource_group.sensitive.name
  key_vault_id = var.sensitive_kv_id
}

resource "azurerm_key_vault_secret" "audit_storage_account_name" {
  name         = var.audit_storage_account_name_secret_name
  value        = module.audit_storage.storage_account_name
  key_vault_id = var.sensitive_kv_id
}
