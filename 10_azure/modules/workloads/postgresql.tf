resource "random_password" "postgres_username" {
  length  = 16
  special = false
  numeric = false
}

resource "random_password" "postgres_password" {
  length  = 32
  special = false
}

module "postgresql" {
  source              = "github.com/unique-ag/terraform-modules.git//modules/azure-postgresql?depth=1&ref=azure-postgresql-2.0.0-rc.2"
  admin_password      = random_password.postgres_password.result
  administrator_login = random_password.postgres_username.result
  name                = var.postgresql_server_name
  delegated_subnet_id = var.postgresql_subnet_id
  private_dns_zone_id = var.postgresql_private_dns_zone_id
  zone                = "1"
  databases = {
    "chat" : { name : "chat", prevent_destroy : false },
    "ingestion" : { name : "ingestion", prevent_destroy : false },
    "theme" : { name : "theme", prevent_destroy : false },
    "scope-management" : { name : "scope-management", prevent_destroy : false },
    "app-repository" : { name : "app-repository", prevent_destroy : false }
  }
  resource_group_name = data.azurerm_resource_group.sensitive.name
  location            = data.azurerm_resource_group.sensitive.location
  tags                = var.tags
  identity_ids        = [var.psql_user_assigned_identity_id]
  #key_vault_id        = var.sensitive_kv_id
}
