module "openai" {
  source                      = "github.com/unique-ag/terraform-modules.git//modules/azure-openai?depth=1&ref=azure-openai-2.4.0"
  resource_group_name         = data.azurerm_resource_group.core.name
  tags                        = var.tags
  endpoint_secret_name_suffix = "-ep"
  cognitive_accounts = {
    "cognitive-account-swedencentral" = {
      name                          = "cognitive-account-swedencentral"
      location                      = "swedencentral"
      local_auth_enabled            = false
      custom_subdomain_name         = var.custom_subdomain_name
      public_network_access_enabled = true # FIXME: use private endpoints
      cognitive_deployments = [
        {
          model_name    = "text-embedding-ada-002"
          model_version = "2"
          name          = "text-embedding-ada-002"
          sku_capacity  = 350
        },
        {
          model_name    = "gpt-4"
          model_version = "0613"
          name          = "gpt-4"
          sku_capacity  = 20
        },
        {
          model_name    = "gpt-35-turbo"
          model_version = "0125"
          name          = "gpt-35-turbo-0125"
          sku_capacity  = 120
        },
        {
          name          = "gpt-4o-2024-11-20"
          model_name    = "gpt-4o"
          model_version = "2024-11-20"
          sku_name      = "Standard"
          sku_capacity  = 50
        }
      ]
    }
  }
  key_vault_id = var.main_kv_id
}

module "document_intelligence" {
  source                = "github.com/Unique-AG/terraform-modules.git//modules/azure-document-intelligence?ref=azure-document-intelligence-3.0.3"
  doc_intelligence_name = "doc-intelligence"
  resource_group_name   = data.azurerm_resource_group.core.name
  tags                  = var.tags

  accounts = {
    "swedencentral-form-recognizer" = {
      location                      = "swedencentral"
      custom_subdomain_name         = var.document_intelligence_custom_subdomain_name
      public_network_access_enabled = true # FIXME: use private endpoints'
      local_auth_enabled            = true # https://github.com/Unique-AG/terraform-modules/issues/79
    }
  }
  key_vault_id = var.main_kv_id
}

module "speech_service" {
  source              = "github.com/unique-ag/terraform-modules.git//modules/azure-speech-service?depth=1&ref=azure-speech-service-4.0.1"
  key_vault_id        = var.sensitive_kv_id
  resource_group_name = data.azurerm_resource_group.core.name
  speech_service_name = "speech-service"
  accounts = {
    "swedencentral-speech" = {
      location              = "swedencentral"
      account_kind          = "SpeechServices"
      account_sku_name      = "S0"
      custom_subdomain_name = var.speech_service_custom_subdomain_name

      private_endpoint = {
        subnet_id           = var.subnet_cognitive_services_id
        vnet_id             = var.vnet_id
        vnet_location       = data.azurerm_resource_group.core.location
        private_dns_zone_id = var.private_dns_zone_speech_service_id
      }

      # Can be used to log audit logs
      # diagnostic_settings = {
      #   log_analytics_workspace_id = var.log_analytics_workspace_id
      #   enabled_log_categories     = ["Audit"]
      # }
    }
  }
}
