output "network_settings_id" {
  description = "ID of the GitHub.Network/networkSettings resource"
  value       = azapi_resource.github_network_settings.output.tags.GitHubId
}
