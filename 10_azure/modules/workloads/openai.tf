module "openai" {
  source                      = "github.com/unique-ag/terraform-modules.git//modules/azure-openai?depth=1&ref=azure-openai-2.0.1"
  resource_group_name         = data.azurerm_resource_group.core.name
  tags                        = var.tags
  endpoint_secret_name_suffix = "-ep"
  cognitive_accounts = {
    "cognitive-account-switzerlandnorth" = {
      name                          = "cognitive-account-switzerlandnorth"
      location                      = "switzerlandnorth"
      local_auth_enabled            = true
      custom_subdomain_name         = var.custom_subdomain_name
      public_network_access_enabled = true # FIXME: use private endpoints
      cognitive_deployments = [
        {
          name          = "text-embedding-ada-002"
          model_name    = "text-embedding-ada-002"
          model_version = "2"
          sku_capacity  = 350
        },
        {
          name          = "gpt-4"
          model_name    = "gpt-4"
          model_version = "0613"
          sku_capacity  = 20
        },
        {
          model_name    = "gpt-35-turbo"
          model_version = "0125"
          name          = "gpt-35-turbo-0125"
          sku_capacity  = 120
        },
      ]
    }
  }
  #key_vault_id = var.main_kv_id
}

module "document_intelligence" {
  source                = "github.com/Unique-AG/terraform-modules.git//modules/azure-document-intelligence?ref=azure-document-intelligence-2.0.0"
  doc_intelligence_name = "doc-intelligence"
  resource_group_name   = data.azurerm_resource_group.core.name
  tags                  = var.tags
  accounts = {
    "switzerlandnorth-form-recognizer" = {
      location = "switzerlandnorth"
    }
  }
  #key_vault_id               = var.main_kv_id
  user_assigned_identity_ids = [var.document_intelligence_user_assigned_identity_id]
}
