output "cluster_workload_identities" {
  description = "This output reflects configurations that must then be applied to the workloads in the cluster. The client_ids are to be used as Managed Identities while the subject must match exactly the Service Accounts Name and Namespace."
  value = [for key, wid in azurerm_federated_identity_credential.afic_workloads : {
    client_id = data.azurerm_kubernetes_cluster.cluster.kubelet_identity[0].client_id
    subject   = wid.subject
  }]
}

output "resource_group_sensitive_name" {
  description = "The name of the sensitive resource group."
  value       = azurerm_resource_group.sensitive.name
}

output "resource_group_core_name" {
  description = "The name of the core resource group."
  value       = azurerm_resource_group.core.name
}

output "psql_user_assigned_identity_id" {
  description = "The ID of the user-assigned identity for PostgreSQL."
  value       = azurerm_user_assigned_identity.psql_identity.id
}

output "ingestion_storage_user_assigned_identity_id" {
  description = "The ID of the user-assigned identity for ingestion storage."
  value       = azurerm_user_assigned_identity.ingestion_storage_identity.id
}

output "ingestion_cache_user_assigned_identity_id" {
  description = "The ID of the user-assigned identity for ingestion cache."
  value       = azurerm_user_assigned_identity.ingestion_cache_identity.id
}

output "document_intelligence_user_assigned_identity_id" {
  description = "The ID of the user-assigned identity for document intelligence."
  value       = azurerm_user_assigned_identity.document_intelligence_identity.id
}

output "resource_group_core_id" {
  description = "The ID of the core resource group."
  value       = azurerm_resource_group.core.id
}

output "resource_group_sensitive_id" {
  description = "The ID of the sensitive resource group."
  value       = azurerm_resource_group.sensitive.id
}

output "aks_workload_identity_client_id" {
  description = "The client ID of the AKS workload identity."
  value       = azurerm_user_assigned_identity.aks_workload_identity.client_id
}

output "key_vault_secrets_provider_client_id" {
  description = "The client ID of the Key Vault secrets provider."
  value       = data.azurerm_kubernetes_cluster.cluster.key_vault_secrets_provider[0].secret_identity[0].client_id
}
