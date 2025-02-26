<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_defender"></a> [defender](#module\_defender) | github.com/unique-ag/terraform-modules.git//modules/azure-defender?depth=1&ref=azure-defender-2.0.0-rc.1 | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_consumption_budget_subscription.subscription_budget](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_subscription) | resource |
| [azurerm_dns_a_record.adnsar_root](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_a_record.adnsar_sub_domains](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_key_vault.main_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault.sensitive_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_private_dns_zone.psql_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.psql-private-dns-zone-vnet-link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.aks_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_provider_registration.azure_alerts_provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration) | resource |
| [azurerm_resource_provider_registration.azure_dashboard_provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration) | resource |
| [azurerm_resource_provider_registration.azure_monitor_provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration) | resource |
| [azuread_service_principal.terraform](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_resource_group.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.sensitive](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_node_rg_name"></a> [aks\_node\_rg\_name](#input\_aks\_node\_rg\_name) | The name of the resource group for AKS nodes. | `string` | n/a | yes |
| <a name="input_aks_public_ip_name"></a> [aks\_public\_ip\_name](#input\_aks\_public\_ip\_name) | n/a | `string` | `"aks_public_ip"` | no |
| <a name="input_azurerm_private_dns_zone_virtual_network_link_name"></a> [azurerm\_private\_dns\_zone\_virtual\_network\_link\_name](#input\_azurerm\_private\_dns\_zone\_virtual\_network\_link\_name) | n/a | `string` | `"PsqlVnetZone.com"` | no |
| <a name="input_budget_contact_emails"></a> [budget\_contact\_emails](#input\_budget\_contact\_emails) | n/a | `set(string)` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client ID for authentication. | `string` | n/a | yes |
| <a name="input_csi_identity_name"></a> [csi\_identity\_name](#input\_csi\_identity\_name) | The name of the CSI identity. | `string` | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | Name for the DNS zone | `string` | n/a | yes |
| <a name="input_dns_zone_root_records"></a> [dns\_zone\_root\_records](#input\_dns\_zone\_root\_records) | List of IP addresses for the root A record in the DNS zone | `set(string)` | n/a | yes |
| <a name="input_dns_zone_sub_domain_records"></a> [dns\_zone\_sub\_domain\_records](#input\_dns\_zone\_sub\_domain\_records) | Map of subdomain names to their respective A record IP addresses | <pre>map(object({<br/>    name    = string<br/>    records = set(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_kv_sku"></a> [kv\_sku](#input\_kv\_sku) | Name of the KeyVault SKU. | `string` | `"standard"` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The name of the Log Analytics workspace. | `string` | n/a | yes |
| <a name="input_main_kv_name"></a> [main\_kv\_name](#input\_main\_kv\_name) | The name of the main key vault. | `string` | n/a | yes |
| <a name="input_psql_private_dns_zone_name"></a> [psql\_private\_dns\_zone\_name](#input\_psql\_private\_dns\_zone\_name) | n/a | `string` | `"psql.postgres.database.azure.com"` | no |
| <a name="input_resource_group_core_location"></a> [resource\_group\_core\_location](#input\_resource\_group\_core\_location) | The core resource group location. | `string` | `"switzerlandnorth"` | no |
| <a name="input_resource_group_core_name"></a> [resource\_group\_core\_name](#input\_resource\_group\_core\_name) | The core resource group name. | `string` | n/a | yes |
| <a name="input_resource_group_sensitive_name"></a> [resource\_group\_sensitive\_name](#input\_resource\_group\_sensitive\_name) | The sensitive resource group name. | `string` | n/a | yes |
| <a name="input_resource_group_vnet_name"></a> [resource\_group\_vnet\_name](#input\_resource\_group\_vnet\_name) | The resource group name for the vnets. | `string` | n/a | yes |
| <a name="input_sensitive_kv_name"></a> [sensitive\_kv\_name](#input\_sensitive\_kv\_name) | The name of the sensitive key vault. | `string` | n/a | yes |
| <a name="input_subscription_budget_amount"></a> [subscription\_budget\_amount](#input\_subscription\_budget\_amount) | The amount for the subscription budget | `number` | `2000` | no |
| <a name="input_subscription_budget_name"></a> [subscription\_budget\_name](#input\_subscription\_budget\_name) | n/a | `string` | `"subscription_budget"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | n/a | yes |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The virtual network id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_public_ip_id"></a> [aks\_public\_ip\_id](#output\_aks\_public\_ip\_id) | ID of the public IP dedicated to the AKS |
| <a name="output_aks_public_ip_name"></a> [aks\_public\_ip\_name](#output\_aks\_public\_ip\_name) | Name of the public IP dedicated to the AKS |
| <a name="output_dns_zone_id"></a> [dns\_zone\_id](#output\_dns\_zone\_id) | n/a |
| <a name="output_dns_zone_name"></a> [dns\_zone\_name](#output\_dns\_zone\_name) | Name of the DNS zone |
| <a name="output_dns_zone_name_servers"></a> [dns\_zone\_name\_servers](#output\_dns\_zone\_name\_servers) | The Name Servers for the DNS zone |
| <a name="output_key_vault_main_id"></a> [key\_vault\_main\_id](#output\_key\_vault\_main\_id) | ID of the main Key Vault |
| <a name="output_key_vault_main_name"></a> [key\_vault\_main\_name](#output\_key\_vault\_main\_name) | Name of the main Key Vault |
| <a name="output_key_vault_sensitive_id"></a> [key\_vault\_sensitive\_id](#output\_key\_vault\_sensitive\_id) | ID of the sensitive Key Vault |
| <a name="output_key_vault_sensitive_name"></a> [key\_vault\_sensitive\_name](#output\_key\_vault\_sensitive\_name) | Name of the sensitive Key Vault |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | ID of the Log Analytics workspace |
| <a name="output_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#output\_log\_analytics\_workspace\_name) | Name of the Log Analytics workspace |
| <a name="output_postgresql_private_dns_zone_id"></a> [postgresql\_private\_dns\_zone\_id](#output\_postgresql\_private\_dns\_zone\_id) | ID of the PostgreSQL private DNS zone |
<!-- END_TF_DOCS -->
