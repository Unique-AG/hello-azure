# Azure

# Terraform resources

See also [identities](modules/identities/README.md), [perimeter](modules/perimeter/README.md) and [workloads](modules/workloads/README.md) for their respective resources.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | 2.2.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.20 |
| <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) | 0.3.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.20 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_identities"></a> [identities](#module\_identities) | ../../terraform-modules/identities | n/a |
| <a name="module_perimeter"></a> [perimeter](#module\_perimeter) | ../../terraform-modules/perimeter | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | Azure/avm-res-network-virtualnetwork/azurerm | v0.7.1 |
| <a name="module_workloads"></a> [workloads](#module\_workloads) | ../../terraform-modules/workloads | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_identity_name"></a> [aks\_identity\_name](#input\_aks\_identity\_name) | Name of the AKS user-assigned identity | `string` | n/a | yes |
| <a name="input_budget_contact_emails"></a> [budget\_contact\_emails](#input\_budget\_contact\_emails) | List of email addresses for budget notifications | `list(string)` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client ID for OIDC | `string` | n/a | yes |
| <a name="input_cluster_admin_user_ids"></a> [cluster\_admin\_user\_ids](#input\_cluster\_admin\_user\_ids) | List of user object IDs that will be granted cluster administrator permissions | `list(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the AKS cluster | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The resource group name for the tfstate container name | `string` | n/a | yes |
| <a name="input_csi_identity_name"></a> [csi\_identity\_name](#input\_csi\_identity\_name) | Name of the CSI identity | `string` | n/a | yes |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | The custom subdomain name to use for the application | `string` | n/a | yes |
| <a name="input_dns_subdomain_records"></a> [dns\_subdomain\_records](#input\_dns\_subdomain\_records) | Map of DNS subdomain records | <pre>map(object({<br/>    name    = string<br/>    records = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | The DNS zone name for the environment | `string` | n/a | yes |
| <a name="input_document_intelligence_custom_subdomain_name"></a> [document\_intelligence\_custom\_subdomain\_name](#input\_document\_intelligence\_custom\_subdomain\_name) | The custom subdomain name to use for the document intelligence | `string` | n/a | yes |
| <a name="input_document_intelligence_identity_name"></a> [document\_intelligence\_identity\_name](#input\_document\_intelligence\_identity\_name) | Name of the document intelligence identity | `string` | n/a | yes |
| <a name="input_gitops_display_name"></a> [gitops\_display\_name](#input\_gitops\_display\_name) | Display name for GitOps application registration | `string` | n/a | yes |
| <a name="input_gitops_maintainer_user_ids"></a> [gitops\_maintainer\_user\_ids](#input\_gitops\_maintainer\_user\_ids) | List of user object IDs that will be granted GitOps maintainer permissions | `list(string)` | n/a | yes |
| <a name="input_grafana_identity_name"></a> [grafana\_identity\_name](#input\_grafana\_identity\_name) | Name of the Grafana user-assigned identity | `string` | n/a | yes |
| <a name="input_ingestion_cache_identity_name"></a> [ingestion\_cache\_identity\_name](#input\_ingestion\_cache\_identity\_name) | Name of the ingestion cache identity | `string` | n/a | yes |
| <a name="input_ingestion_storage_identity_name"></a> [ingestion\_storage\_identity\_name](#input\_ingestion\_storage\_identity\_name) | Name of the ingestion storage identity | `string` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The key for the tfstate | `string` | n/a | yes |
| <a name="input_keyvault_secret_writer_user_ids"></a> [keyvault\_secret\_writer\_user\_ids](#input\_keyvault\_secret\_writer\_user\_ids) | List of user object IDs that will be granted permissions to write secrets to Key Vault | `list(string)` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The version of Kubernetes to use for the AKS cluster | `string` | `"1.30.0"` | no |
| <a name="input_kv_sku"></a> [kv\_sku](#input\_kv\_sku) | SKU for Key Vault | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Name of the Log Analytics workspace | `string` | n/a | yes |
| <a name="input_main_kv_name"></a> [main\_kv\_name](#input\_main\_kv\_name) | Name of the main Key Vault | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix used for naming resources | `string` | n/a | yes |
| <a name="input_prometheus_kubernetes_recording_rules"></a> [prometheus\_kubernetes\_recording\_rules](#input\_prometheus\_kubernetes\_recording\_rules) | Kubernetes level recording rules for Prometheus monitoring | <pre>list(object({<br/>    enabled    = optional(bool, true)<br/>    record     = string<br/>    expression = string<br/>    labels     = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_prometheus_node_recording_rules"></a> [prometheus\_node\_recording\_rules](#input\_prometheus\_node\_recording\_rules) | Node level recording rules for Prometheus monitoring | <pre>list(object({<br/>    enabled    = optional(bool, true)<br/>    record     = string<br/>    expression = string<br/>    labels     = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_prometheus_ux_recording_rules"></a> [prometheus\_ux\_recording\_rules](#input\_prometheus\_ux\_recording\_rules) | UX level recording rules for Prometheus monitoring | <pre>list(object({<br/>    enabled    = optional(bool, true)<br/>    record     = string<br/>    expression = string<br/>    labels     = optional(map(string))<br/>  }))</pre> | `null` | no |
| <a name="input_psql_identity_name"></a> [psql\_identity\_name](#input\_psql\_identity\_name) | Name of the PostgreSQL identity | `string` | n/a | yes |
| <a name="input_resource_audit_location"></a> [resource\_audit\_location](#input\_resource\_audit\_location) | The location for resource audit resources | `string` | n/a | yes |
| <a name="input_resource_group_core_location"></a> [resource\_group\_core\_location](#input\_resource\_group\_core\_location) | The location for core resource group | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name for the tfstate. | `string` | n/a | yes |
| <a name="input_resource_group_sensitive_location"></a> [resource\_group\_sensitive\_location](#input\_resource\_group\_sensitive\_location) | The location for sensitive resource group | `string` | n/a | yes |
| <a name="input_resource_vnet_location"></a> [resource\_vnet\_location](#input\_resource\_vnet\_location) | The location for virtual network resources | `string` | n/a | yes |
| <a name="input_sensitive_kv_name"></a> [sensitive\_kv\_name](#input\_sensitive\_kv\_name) | Name of the sensitive key vault | `string` | n/a | yes |
| <a name="input_speech_service_custom_subdomain_name"></a> [speech\_service\_custom\_subdomain\_name](#input\_speech\_service\_custom\_subdomain\_name) | The custom subdomain name to use for the speech service | `string` | n/a | yes |
| <a name="input_speech_service_private_dns_zone_name"></a> [speech\_service\_private\_dns\_zone\_name](#input\_speech\_service\_private\_dns\_zone\_name) | The name of the private DNS zone for the speech service. | `string` | n/a | yes |
| <a name="input_speech_service_private_dns_zone_virtual_network_link_name"></a> [speech\_service\_private\_dns\_zone\_virtual\_network\_link\_name](#input\_speech\_service\_private\_dns\_zone\_virtual\_network\_link\_name) | The name of the virtual network link for the speech service private DNS zone. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The resource group name for the storage account name | `string` | n/a | yes |
| <a name="input_subnet_agw_cidr"></a> [subnet\_agw\_cidr](#input\_subnet\_agw\_cidr) | CIDR block for the Application Gateway subnet | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The UUID ID of the suscription (not the full Azure Resource ID). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | n/a | yes |
| <a name="input_telemetry_observer_user_ids"></a> [telemetry\_observer\_user\_ids](#input\_telemetry\_observer\_user\_ids) | List of user object IDs that will be granted permissions to view telemetry data | `list(string)` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The ID of the tenenat | `string` | n/a | yes |
| <a name="input_use_oidc"></a> [use\_oidc](#input\_use\_oidc) | Whether to use OIDC | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | The ID of the Azure Container Registry. |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | The login server of the Azure Container Registry. |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | The name of the Azure Container Registry. |
| <a name="output_aks_cluster_id"></a> [aks\_cluster\_id](#output\_aks\_cluster\_id) | The ID of the AKS cluster. |
| <a name="output_aks_workload_identity_client_id"></a> [aks\_workload\_identity\_client\_id](#output\_aks\_workload\_identity\_client\_id) | The client ID of the AKS workload identity. |
| <a name="output_cluster_kublet_client_id"></a> [cluster\_kublet\_client\_id](#output\_cluster\_kublet\_client\_id) | The client ID of the cluster kubelet. |
| <a name="output_container_registry_url"></a> [container\_registry\_url](#output\_container\_registry\_url) | The URL of the container registry. |
| <a name="output_dns_zone_name"></a> [dns\_zone\_name](#output\_dns\_zone\_name) | Name of the DNS zone |
| <a name="output_dns_zone_name_servers"></a> [dns\_zone\_name\_servers](#output\_dns\_zone\_name\_servers) | The Name Servers for the DNS zone |
| <a name="output_document_inteliigence_endpoint_definitions_secret_name"></a> [document\_inteliigence\_endpoint\_definitions\_secret\_name](#output\_document\_inteliigence\_endpoint\_definitions\_secret\_name) | The secret name for document intelligence endpoint definitions. |
| <a name="output_document_inteliigence_endpoints_secret_name"></a> [document\_inteliigence\_endpoints\_secret\_name](#output\_document\_inteliigence\_endpoints\_secret\_name) | The secret name for document intelligence endpoints. |
| <a name="output_encryption_key_app_repository_secret_name"></a> [encryption\_key\_app\_repository\_secret\_name](#output\_encryption\_key\_app\_repository\_secret\_name) | The secret name for the encryption key of the app repository. |
| <a name="output_encryption_key_ingestion_secret_name"></a> [encryption\_key\_ingestion\_secret\_name](#output\_encryption\_key\_ingestion\_secret\_name) | The secret name for the encryption key of ingestion. |
| <a name="output_encryption_key_node_chat_lxm_secret_name"></a> [encryption\_key\_node\_chat\_lxm\_secret\_name](#output\_encryption\_key\_node\_chat\_lxm\_secret\_name) | The secret name for the encryption key of the node chat LXM. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The principal ID of the identity. |
| <a name="output_ingestion_cache_connection_string_1_secret_name"></a> [ingestion\_cache\_connection\_string\_1\_secret\_name](#output\_ingestion\_cache\_connection\_string\_1\_secret\_name) | The secret name for ingestion cache connection string 1. |
| <a name="output_ingestion_cache_connection_string_2_secret_name"></a> [ingestion\_cache\_connection\_string\_2\_secret\_name](#output\_ingestion\_cache\_connection\_string\_2\_secret\_name) | The secret name for ingestion cache connection string 2. |
| <a name="output_ingestion_storage_connection_string_1_secret_name"></a> [ingestion\_storage\_connection\_string\_1\_secret\_name](#output\_ingestion\_storage\_connection\_string\_1\_secret\_name) | The secret name for ingestion storage connection string 1. |
| <a name="output_ingestion_storage_connection_string_2_secret_name"></a> [ingestion\_storage\_connection\_string\_2\_secret\_name](#output\_ingestion\_storage\_connection\_string\_2\_secret\_name) | The secret name for ingestion storage connection string 2. |
| <a name="output_key_vault_secrets_provider_client_id"></a> [key\_vault\_secrets\_provider\_client\_id](#output\_key\_vault\_secrets\_provider\_client\_id) | The client ID of the Key Vault secrets provider. |
| <a name="output_main_keyvault_name"></a> [main\_keyvault\_name](#output\_main\_keyvault\_name) | The name of the main Key Vault. |
| <a name="output_oai_cognitive_account_endpoints_secret_names"></a> [oai\_cognitive\_account\_endpoints\_secret\_names](#output\_oai\_cognitive\_account\_endpoints\_secret\_names) | The secret names for OAI cognitive account endpoints. |
| <a name="output_oai_model_version_endpoints_secret_name"></a> [oai\_model\_version\_endpoints\_secret\_name](#output\_oai\_model\_version\_endpoints\_secret\_name) | The secret name for OAI model version endpoints. |
| <a name="output_psql_database_connection_strings_secret_names"></a> [psql\_database\_connection\_strings\_secret\_names](#output\_psql\_database\_connection\_strings\_secret\_names) | The secret names for PostgreSQL database connection strings. |
| <a name="output_psql_host_secret_name"></a> [psql\_host\_secret\_name](#output\_psql\_host\_secret\_name) | The secret name for PostgreSQL host. |
| <a name="output_psql_password_secret_name"></a> [psql\_password\_secret\_name](#output\_psql\_password\_secret\_name) | The secret name for PostgreSQL password. |
| <a name="output_psql_port_secret_name"></a> [psql\_port\_secret\_name](#output\_psql\_port\_secret\_name) | The secret name for PostgreSQL port. |
| <a name="output_psql_username_secret_name"></a> [psql\_username\_secret\_name](#output\_psql\_username\_secret\_name) | The secret name for PostgreSQL username. |
| <a name="output_rabbitmq_password_chat_secret_name"></a> [rabbitmq\_password\_chat\_secret\_name](#output\_rabbitmq\_password\_chat\_secret\_name) | The secret name for RabbitMQ password for chat. |
| <a name="output_resource_group_core_name"></a> [resource\_group\_core\_name](#output\_resource\_group\_core\_name) | The name of the core resource group. |
| <a name="output_resource_group_vnet_name"></a> [resource\_group\_vnet\_name](#output\_resource\_group\_vnet\_name) | Name of the resource group for the vnet |
| <a name="output_sensitive_keyvault_name"></a> [sensitive\_keyvault\_name](#output\_sensitive\_keyvault\_name) | The name of the sensitive Key Vault. |
| <a name="output_zitadel_db_user_password_secret_name"></a> [zitadel\_db\_user\_password\_secret\_name](#output\_zitadel\_db\_user\_password\_secret\_name) | The secret name for the Zitadel database user password. |
| <a name="output_zitadel_master_key_secret_name"></a> [zitadel\_master\_key\_secret\_name](#output\_zitadel\_master\_key\_secret\_name) | The secret name for the Zitadel master key. |
| <a name="output_zitadel_pat_secret_name"></a> [zitadel\_pat\_secret\_name](#output\_zitadel\_pat\_secret\_name) | Name of the manual secret containing Zitadel PAT |
<!-- END_TF_DOCS -->
