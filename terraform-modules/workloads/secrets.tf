resource "random_password" "rabbitmq_password_chat" {
  keepers = {
    version = "1"
  }
  length  = 24
  special = false
}


resource "azurerm_key_vault_secret" "rabbitmq_password_chat" {
  name            = var.rabbitmq_password_chat_secret_name
  value           = random_password.rabbitmq_password_chat.result
  key_vault_id    = var.sensitive_kv_id
  expiration_date = "2099-12-31T23:59:59Z"
}

resource "random_password" "zitadel_db_user_password" {
  keepers = {
    version = "1"
  }
  length  = 32 # must be 32 acc. to docs
  special = false
}

resource "azurerm_key_vault_secret" "zitadel_db_user_password" {
  name            = var.zitadel_db_user_password_secret_name
  value           = random_password.zitadel_db_user_password.result
  key_vault_id    = var.sensitive_kv_id
  expiration_date = "2099-12-31T23:59:59Z"
}


resource "random_password" "encryption_key_app_repository" {
  keepers = {
    version = "1"
  }
  length  = 32
  special = false
}

resource "azurerm_key_vault_secret" "encryption_key_app_repository" {
  name            = var.encryption_key_app_repository_secret_name
  value           = random_password.encryption_key_app_repository.result
  key_vault_id    = var.sensitive_kv_id
  expiration_date = "2099-12-31T23:59:59Z"
}

resource "random_id" "encryption_key_node_chat_lxm" {
  keepers = {
    version = "1"
  }
  byte_length = 32
}

resource "azurerm_key_vault_secret" "encryption_key_node_chat_lxm" {
  name            = var.encryption_key_node_chat_lxm_secret_name
  value           = random_id.encryption_key_node_chat_lxm.hex
  key_vault_id    = var.sensitive_kv_id
  expiration_date = "2099-12-31T23:59:59Z"
}

resource "random_id" "encryption_key_ingestion" {
  keepers = {
    version = "1"
  }
  byte_length = 32
}

resource "azurerm_key_vault_secret" "encryption_key_ingestion" {
  name            = var.encryption_key_ingestion_secret_name
  value           = random_id.encryption_key_ingestion.hex
  key_vault_id    = var.sensitive_kv_id
  expiration_date = "2099-12-31T23:59:59Z"
}

resource "random_password" "zitadel_master_key" {
  keepers = {
    version = "1"
  }
  length  = 32 # must be 32 acc. to docs
  special = false
}

resource "azurerm_key_vault_secret" "zitadel_master_key" {
  name         = var.zitadel_master_key_secret_name
  value        = random_password.zitadel_master_key.result
  key_vault_id = var.sensitive_kv_id
}

resource "azurerm_key_vault_secret" "zitadel_pat" {
  name         = var.zitadel_pat_secret_name
  value        = "<TO BE SET MANUALLY>"
  key_vault_id = var.main_kv_id

  lifecycle {
    ignore_changes = [value, tags]
  }
}
