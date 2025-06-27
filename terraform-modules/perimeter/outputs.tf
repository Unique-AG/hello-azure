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
  value       = azurerm_private_dns_zone.private_dns_zones["psql"].id
}
output "storage_private_dns_zone_id" {
  description = "ID of the storage private DNS zone"
  value       = azurerm_private_dns_zone.private_dns_zones["storage"].id
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

output "speech_service_private_dns_zone_id" {
  description = "ID of the speech service private DNS zone"
  value       = azurerm_private_dns_zone.private_dns_zones["speech_service"].id
}

output "private_dns_zone_aoi_id" {
  description = "ID of the aoi private DNS zone"
  value       = azurerm_private_dns_zone.private_dns_zones["aoi"].id
}

output "private_dns_zone_cognitive_services_id" {
  description = "ID of the cognitive services private DNS zone"
  value       = azurerm_private_dns_zone.private_dns_zones["cognitive_services"].id
}

output "private_dns_zone_speech_service_id" {
  description = "ID of the speech service private DNS zone"
  value       = azurerm_private_dns_zone.private_dns_zones["speech_service"].id
}

output "private_dns_zone_storage_id" {
  description = "ID of the storage private DNS zone"
  value       = azurerm_private_dns_zone.private_dns_zones["storage"].id
}

output "private_dns_zone_redis_id" {
  description = "ID of the redis private DNS zone"
  value       = azurerm_private_dns_zone.private_dns_zones["redis"].id
}

output "private_dns_zone_psql_id" {
  description = "ID of the psql private DNS zone"
  value       = azurerm_private_dns_zone.private_dns_zones["psql"].id
}

output "private_dns_zone_links" {
  description = "ID of the private DNS zone links"
  value       = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_links
}

output "private_dns_zone_links_ids" {
  description = "ID of the private DNS zone links"
  value       = azurerm_private_dns_zone_virtual_network_link.private_dns_zone_links[*].id
}