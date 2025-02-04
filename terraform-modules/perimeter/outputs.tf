output "aks_public_ip_name" {
  description = "Name of the public IP dedicated to the AKS"
  value       = azurerm_public_ip.aks_public_ip.name
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.this.name
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.this.id
}

output "aks_public_ip_id" {
  description = "ID of the public IP dedicated to the AKS"
  value       = azurerm_public_ip.aks_public_ip.id
}

output "key_vault_sensitive_id" {
  description = "ID of the sensitive Key Vault"
  value       = azurerm_key_vault.sensitive_kv.id
}

output "key_vault_main_id" {
  description = "ID of the main Key Vault"
  value       = azurerm_key_vault.main_kv.id
}

output "key_vault_sensitive_name" {
  description = "Name of the sensitive Key Vault"
  value       = azurerm_key_vault.sensitive_kv.name
}

output "key_vault_main_name" {
  description = "Name of the main Key Vault"
  value       = azurerm_key_vault.main_kv.name
}
output "postgresql_private_dns_zone_id" {
  description = "ID of the PostgreSQL private DNS zone"
  value       = azurerm_private_dns_zone.psql_private_dns_zone.id
}

output "dns_zone_name_servers" {
  description = "The Name Servers for the DNS zone"
  value       = azurerm_dns_zone.dns_zone.name_servers
}

output "dns_zone_name" {
  description = "Name of the DNS zone"
  value       = azurerm_dns_zone.dns_zone.name
}

output "dns_zone_id" {
  value = azurerm_dns_zone.dns_zone.id
}

