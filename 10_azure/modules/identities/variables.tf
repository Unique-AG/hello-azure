variable "resource_group_core_name" {
  description = "The core resource group name."
  type        = string
  default     = "resource-group-core"
}

variable "resource_group_sensitive_name" {
  description = "The sensitive resource group name."
  type        = string
  default     = "resource-group-sensitive"
}

variable "resource_group_core_location" {
  description = "The location of core resource group name."
  type        = string
  default     = "switzerlandnorth"
}

variable "resource_group_sensitive_location" {
  description = "The location of sensitive resource group name."
  type        = string
  default     = "switzerlandnorth"
}

variable "resource_audit_location" {
  description = "The location of audit resource group name."
  type        = string
  default     = "switzerlandnorth"
}

variable "resource_vnet_location" {
  description = "The location of vnet resource group name."
  type        = string
  default     = "switzerlandnorth"
}

variable "cluster_workload_identities" {
  description = "Workload Identities to be federated into the cluster."
  type = map(object({
    name      = string
    namespace = string
  }))
  default = {
    "backend-service-chat" : {
      name      = "backend-service-chat"
      namespace = "unique"
    }
    "backend-service-ingestion-worker" : {
      name      = "backend-service-ingestion-worker"
      namespace = "unique"
    }
    "backend-service-ingestion" : {
      name      = "backend-service-ingestion"
      namespace = "unique"
    }
    "assistants-core" : {
      name      = "assistants-core"
      namespace = "unique"
    }
  }
}

variable "service_principal_display_name" {
  description = "Display name of the Azure AD service principal."
  type        = string
  default     = "default-service-principal"
  validation {
    condition     = length(var.service_principal_display_name) > 0
    error_message = "The service_principal_display_name cannot be an empty string."
  }
}

variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
}

variable "cluster_id" {
  description = "The ID of the cluster."
  type        = string
}

variable "psql_user_assigned_identity_name" {
  description = "The name of the PostgreSQL user-assigned identity."
  type        = string
}

variable "aks_user_assigned_identity_name" {
  description = "The name of the AKS user-assigned identity."
  type        = string
}

variable "sensitive_kv_id" {
  description = "The ID of the sensitive key vault."
  type        = string
}

variable "main_kv_id" {
  description = "The ID of the main key vault."
  type        = string
}

variable "client_id" {
  description = "The client ID for authentication."
  type        = string
}

variable "ingestion_cache_identity_name" {
  description = "The name of the ingestion cache identity."
  type        = string
}

variable "ingestion_storage_identity_name" {
  description = "The name of the ingestion storage identity."
  type        = string
}

variable "document_intelligence_identity_name" {
  description = "The name of the document intelligence identity."
  type        = string
}
variable "cluster_admins" {
  type = set(string)
}
variable "main_keyvault_secret_writers" {
  type = set(string)
}
variable "telemetry_observers" {
  type = set(string)
}

variable "gitops_maintainers" {
  type = set(string)
}

variable "telemetry_observer_group_display_name" {
  description = "Display name for the Telemetry Observer group"
  type        = string
  default     = "Telemetry Observer"
}

variable "sensitive_data_observer_group_display_name" {
  description = "Display name for the Sensitive Data Observer group"
  type        = string
  default     = "Sensitive Data Observer"
}

variable "devops_group_display_name" {
  description = "Display name for the DevOps group"
  type        = string
  default     = "DevOps"
}


variable "main_keyvault_secret_writer_group_display_name" {
  description = "Display name for the Main Key Vault writer group"
  type        = string
  default     = "Main KeyVault writer"
}

variable "emergency_admin_group_display_name" {
  description = "Display name for the Emergency Admin group"
  type        = string
  default     = "Emergency Admin"
}

variable "admin_kubernetes_cluster_group_display_name" {
  description = "Display name for the Admin Kubernetes Cluster group"
  type        = string
  default     = "Admin Kubernetes Cluster"
}

variable "application_gateway_id" {
  description = "The ID of the Application Gateway."
  type        = string
}
variable "dns_zone_id" {
  description = "ID of the DNS zone"
  type        = string
}
variable "application_secret_display_name" {
  description = "Display name for the GitOps application secret"
  type        = string
}
variable "dns_zone_name" {
  description = "Name of the DNS zone"
  type        = string
}
variable "application_registration_gitops_display_name" {
  description = "Display name for the GitOps application registration"
  type        = string
}
