# Environment-specific configuration
dns_zone_name                       = "hello.azure.unique.dev"
name_prefix                         = "hello-azure"
subnet_agw_cidr                     = "10.201.3.0/28"
budget_contact_emails               = ["support@unique.ch"]
kv_sku                              = "premium"
log_analytics_workspace_name        = "loganalytics"
aks_identity_name                   = "aks-identity"
cluster_name                        = "aks-cluster"
gitops_display_name                 = "GitOps"
document_intelligence_identity_name = "document-intelligence-identity"
ingestion_cache_identity_name       = "ingestion-cache-identity"
ingestion_storage_identity_name     = "ingestion-storage-identity"
psql_identity_name                  = "psql-identity"
csi_identity_name                   = "csi_identity"
main_kv_name                        = "helloazuremain"
sensitive_kv_name                   = "helloazuresensitive"

# DNS subdomain records
dns_subdomain_records = {
  api = {
    name    = "api"
    records = [] # Will be populated dynamically
  }
  argo = {
    name    = "argo"
    records = [] # Will be populated dynamically
  }
  zitadel = {
    name    = "id"
    records = [] # Will be populated dynamically
  }
}

# Tags
tags = {
  app = "hello-azure"
}

# Resource locations
resource_audit_location           = "swedencentral"
resource_group_core_location      = "swedencentral"
resource_group_sensitive_location = "swedencentral"
resource_vnet_location            = "swedencentral"

# User permissions
cluster_admin_user_ids = [
  "4b89a1f0-8038-4929-81e6-6d128dac7aa0",
  "084a1c45-5010-4aab-bab6-7b86a9d10e5c",
  "3b48f167-cb68-4655-b45b-878e170af84d"
]
gitops_maintainer_user_ids = [
  "4b89a1f0-8038-4929-81e6-6d128dac7aa0",
  "084a1c45-5010-4aab-bab6-7b86a9d10e5c",
  "3b48f167-cb68-4655-b45b-878e170af84d"
]
keyvault_secret_writer_user_ids = [
  "4b89a1f0-8038-4929-81e6-6d128dac7aa0",
  "084a1c45-5010-4aab-bab6-7b86a9d10e5c",
  "3b48f167-cb68-4655-b45b-878e170af84d"
]
telemetry_observer_user_ids = [
  "4b89a1f0-8038-4929-81e6-6d128dac7aa0",
  "084a1c45-5010-4aab-bab6-7b86a9d10e5c",
  "3b48f167-cb68-4655-b45b-878e170af84d"
]

custom_subdomain_name = "hello-azure" 