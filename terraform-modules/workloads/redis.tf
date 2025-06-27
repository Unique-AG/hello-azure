module "redis" {
  source                        = "github.com/unique-ag/terraform-modules.git//modules/azure-redis?depth=1&ref=azure-redis-2.0.0"
  name                          = var.redis_name
  resource_group_name           = data.azurerm_resource_group.sensitive.name
  location                      = data.azurerm_resource_group.sensitive.location
  public_network_access_enabled = false
  private_endpoint = {
    subnet_id = var.subnet_redis_id
    private_dns_zone_id = var.private_dns_zone_redis_id
  }
  tags                          = var.tags
  key_vault_id                  = var.sensitive_kv_id
}
