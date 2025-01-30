module "redis" {
  source                        = "github.com/unique-ag/terraform-modules.git//modules/azure-redis?depth=1&ref=fix/add-missing-outputs"
  name                          = var.redis_name
  resource_group_name           = data.azurerm_resource_group.sensitive.name
  location                      = data.azurerm_resource_group.sensitive.location
  public_network_access_enabled = false
  tags                          = var.tags
  key_vault_id                  = var.sensitive_kv_id
}
