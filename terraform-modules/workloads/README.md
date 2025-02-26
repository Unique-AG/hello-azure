<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application_gateway"></a> [application\_gateway](#module\_application\_gateway) | github.com/Unique-AG/terraform-modules.git//modules/azure-application-gateway | azure-application-gateway-2.0.0 |
| <a name="module_document_intelligence"></a> [document\_intelligence](#module\_document\_intelligence) | github.com/Unique-AG/terraform-modules.git//modules/azure-document-intelligence | azure-document-intelligence-2.0.0 |
| <a name="module_ingestion_cache"></a> [ingestion\_cache](#module\_ingestion\_cache) | github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-2.0.2 | n/a |
| <a name="module_ingestion_storage"></a> [ingestion\_storage](#module\_ingestion\_storage) | github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-2.0.2 | n/a |
| <a name="module_kubernetes_cluster"></a> [kubernetes\_cluster](#module\_kubernetes\_cluster) | github.com/Unique-AG/terraform-modules.git//modules/azure-kubernetes-service | azure-kubernetes-service-2.0.0 |
| <a name="module_openai"></a> [openai](#module\_openai) | github.com/unique-ag/terraform-modules.git//modules/azure-openai?depth=1&ref=azure-openai-2.0.3 | n/a |
| <a name="module_postgresql"></a> [postgresql](#module\_postgresql) | github.com/unique-ag/terraform-modules.git//modules/azure-postgresql?depth=1&ref=azure-postgresql-2.0.0-rc.2 | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | github.com/unique-ag/terraform-modules.git//modules/azure-redis?depth=1&ref=azure-redis-2.0.0-rc.2 | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_key_vault_secret.encryption_key_app_repository](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.encryption_key_ingestion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.encryption_key_node_chat_lxm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.rabbitmq_password_chat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.zitadel_db_user_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.zitadel_master_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.zitadel_pat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_monitor_diagnostic_setting.acr_diagnostic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [random_id.encryption_key_ingestion](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.encryption_key_node_chat_lxm](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.encryption_key_app_repository](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.postgres_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.postgres_username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.rabbitmq_password_chat](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.zitadel_db_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.zitadel_master_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.sensitive](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_public_ip_id"></a> [aks\_public\_ip\_id](#input\_aks\_public\_ip\_id) | The ID of the AKS public IP. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the AKS cluster. | `string` | n/a | yes |
| <a name="input_container_registry_name"></a> [container\_registry\_name](#input\_container\_registry\_name) | n/a | `string` | `"uniquehelloazure"` | no |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | n/a | `string` | `"hello-azure-unique-dev"` | no |
| <a name="input_document_intelligence_user_assigned_identity_id"></a> [document\_intelligence\_user\_assigned\_identity\_id](#input\_document\_intelligence\_user\_assigned\_identity\_id) | The ID of the document intelligence user-assigned identity. | `string` | n/a | yes |
| <a name="input_encryption_key_app_repository_secret_name"></a> [encryption\_key\_app\_repository\_secret\_name](#input\_encryption\_key\_app\_repository\_secret\_name) | n/a | `string` | `"encryption-key-app-repository"` | no |
| <a name="input_encryption_key_ingestion_secret_name"></a> [encryption\_key\_ingestion\_secret\_name](#input\_encryption\_key\_ingestion\_secret\_name) | n/a | `string` | `"encryption-key-ingestion"` | no |
| <a name="input_encryption_key_node_chat_lxm_secret_name"></a> [encryption\_key\_node\_chat\_lxm\_secret\_name](#input\_encryption\_key\_node\_chat\_lxm\_secret\_name) | n/a | `string` | `"encryption-key-chat-lxm"` | no |
| <a name="input_ingestion_cache_connection_string_1_secret_name"></a> [ingestion\_cache\_connection\_string\_1\_secret\_name](#input\_ingestion\_cache\_connection\_string\_1\_secret\_name) | n/a | `string` | `"ingestion-cache-connection-string-1"` | no |
| <a name="input_ingestion_cache_connection_string_2_secret_name"></a> [ingestion\_cache\_connection\_string\_2\_secret\_name](#input\_ingestion\_cache\_connection\_string\_2\_secret\_name) | n/a | `string` | `"ingestion-cache-connection-string-2"` | no |
| <a name="input_ingestion_cache_sa_name"></a> [ingestion\_cache\_sa\_name](#input\_ingestion\_cache\_sa\_name) | n/a | `string` | `"helloazureingcache"` | no |
| <a name="input_ingestion_cache_user_assigned_identity_id"></a> [ingestion\_cache\_user\_assigned\_identity\_id](#input\_ingestion\_cache\_user\_assigned\_identity\_id) | The ID of the ingestion cache user-assigned identity. | `string` | n/a | yes |
| <a name="input_ingestion_storage_connection_string_1_secret_name"></a> [ingestion\_storage\_connection\_string\_1\_secret\_name](#input\_ingestion\_storage\_connection\_string\_1\_secret\_name) | n/a | `string` | `"ingestion-storage-connection-string-1"` | no |
| <a name="input_ingestion_storage_connection_string_2_secret_name"></a> [ingestion\_storage\_connection\_string\_2\_secret\_name](#input\_ingestion\_storage\_connection\_string\_2\_secret\_name) | n/a | `string` | `"ingestion-storage-connection-string-2"` | no |
| <a name="input_ingestion_storage_sa_name"></a> [ingestion\_storage\_sa\_name](#input\_ingestion\_storage\_sa\_name) | n/a | `string` | `"helloazureingstorage"` | no |
| <a name="input_ingestion_storage_user_assigned_identity_id"></a> [ingestion\_storage\_user\_assigned\_identity\_id](#input\_ingestion\_storage\_user\_assigned\_identity\_id) | The ID of the ingestion storage user-assigned identity. | `string` | n/a | yes |
| <a name="input_ip_name"></a> [ip\_name](#input\_ip\_name) | Name of the public IP for the Application Gateway | `string` | `"default-public-ip-name"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics workspace. | `string` | n/a | yes |
| <a name="input_main_kv_id"></a> [main\_kv\_id](#input\_main\_kv\_id) | The ID of the main key vault. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for the name of the Application Gateway | `string` | `"agw"` | no |
| <a name="input_node_resource_group_name"></a> [node\_resource\_group\_name](#input\_node\_resource\_group\_name) | The name of the resource group for AKS nodes. | `string` | n/a | yes |
| <a name="input_postgresql_private_dns_zone_id"></a> [postgresql\_private\_dns\_zone\_id](#input\_postgresql\_private\_dns\_zone\_id) | n/a | `string` | n/a | yes |
| <a name="input_postgresql_server_name"></a> [postgresql\_server\_name](#input\_postgresql\_server\_name) | The name of the PostgreSQL server. | `string` | n/a | yes |
| <a name="input_postgresql_subnet_id"></a> [postgresql\_subnet\_id](#input\_postgresql\_subnet\_id) | ID of the subnet dedicated to the PostgreSQL | `string` | n/a | yes |
| <a name="input_psql_user_assigned_identity_id"></a> [psql\_user\_assigned\_identity\_id](#input\_psql\_user\_assigned\_identity\_id) | The ID of the PostgreSQL user-assigned identity. | `string` | n/a | yes |
| <a name="input_rabbitmq_password_chat_secret_name"></a> [rabbitmq\_password\_chat\_secret\_name](#input\_rabbitmq\_password\_chat\_secret\_name) | The name of the secret containing the rabbitmq password. | `string` | `"rabbitmq-password-chat"` | no |
| <a name="input_redis_name"></a> [redis\_name](#input\_redis\_name) | n/a | `string` | `"uniquehelloazureredis"` | no |
| <a name="input_registry_diagnostic_name"></a> [registry\_diagnostic\_name](#input\_registry\_diagnostic\_name) | n/a | `string` | `"log-helloazure"` | no |
| <a name="input_resource_group_core_location"></a> [resource\_group\_core\_location](#input\_resource\_group\_core\_location) | The core resource group location. | `string` | `"westeurope"` | no |
| <a name="input_resource_group_core_name"></a> [resource\_group\_core\_name](#input\_resource\_group\_core\_name) | The core resource group name. | `string` | n/a | yes |
| <a name="input_resource_group_sensitive_name"></a> [resource\_group\_sensitive\_name](#input\_resource\_group\_sensitive\_name) | The sensitive resource group name. | `string` | n/a | yes |
| <a name="input_sensitive_kv_id"></a> [sensitive\_kv\_id](#input\_sensitive\_kv\_id) | The ID of the sensitive key vault. | `string` | n/a | yes |
| <a name="input_subnet_agw_cidr"></a> [subnet\_agw\_cidr](#input\_subnet\_agw\_cidr) | The CIDR range of the application gateway subnet. | `string` | n/a | yes |
| <a name="input_subnet_agw_id"></a> [subnet\_agw\_id](#input\_subnet\_agw\_id) | The ID of the application gateway subnet. | `string` | n/a | yes |
| <a name="input_subnet_aks_nodes_id"></a> [subnet\_aks\_nodes\_id](#input\_subnet\_aks\_nodes\_id) | The ID of the AKS nodes subnet. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant ID for the Azure subscription. | `string` | n/a | yes |
| <a name="input_zitadel_db_user_password_secret_name"></a> [zitadel\_db\_user\_password\_secret\_name](#input\_zitadel\_db\_user\_password\_secret\_name) | n/a | `string` | `"zitadel-db-user-password"` | no |
| <a name="input_zitadel_master_key_secret_name"></a> [zitadel\_master\_key\_secret\_name](#input\_zitadel\_master\_key\_secret\_name) | n/a | `string` | `"zitadel-master-key"` | no |
| <a name="input_zitadel_pat_secret_name"></a> [zitadel\_pat\_secret\_name](#input\_zitadel\_pat\_secret\_name) | Name of the empty secret placeholder for the Zitadel PAT to be created for manually setting the value later | `string` | `"manual-zitadel-scope-mgmt-pat"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | The ID of the Azure Container Registry. |
| <a name="output_acr_login_server"></a> [acr\_login\_server](#output\_acr\_login\_server) | The login server of the Azure Container Registry. |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | The name of the Azure Container Registry. |
| <a name="output_aks_cluster_id"></a> [aks\_cluster\_id](#output\_aks\_cluster\_id) | The ID of the AKS cluster. |
| <a name="output_application_gateway_id"></a> [application\_gateway\_id](#output\_application\_gateway\_id) | n/a |
| <a name="output_application_gateway_ip_address"></a> [application\_gateway\_ip\_address](#output\_application\_gateway\_ip\_address) | n/a |
| <a name="output_cluster_kublet_client_id"></a> [cluster\_kublet\_client\_id](#output\_cluster\_kublet\_client\_id) | The client ID of the Kubernetes cluster's kubelet identity. |
| <a name="output_cluster_kublet_object_id"></a> [cluster\_kublet\_object\_id](#output\_cluster\_kublet\_object\_id) | The object ID of the Kubernetes cluster's kubelet identity. |
| <a name="output_container_registry_url"></a> [container\_registry\_url](#output\_container\_registry\_url) | The URL of the Azure Container Registry. |
| <a name="output_csi_user_assigned_identity_name"></a> [csi\_user\_assigned\_identity\_name](#output\_csi\_user\_assigned\_identity\_name) | The name of the user-assigned identity for the CSI driver. |
| <a name="output_document_inteliigence_endpoint_definitions_secret_name"></a> [document\_inteliigence\_endpoint\_definitions\_secret\_name](#output\_document\_inteliigence\_endpoint\_definitions\_secret\_name) | The secret name for the document intelligence endpoint definitions. |
| <a name="output_document_inteliigence_endpoints_secret_name"></a> [document\_inteliigence\_endpoints\_secret\_name](#output\_document\_inteliigence\_endpoints\_secret\_name) | The secret name for the document intelligence endpoints. |
| <a name="output_encryption_key_app_repository_secret_name"></a> [encryption\_key\_app\_repository\_secret\_name](#output\_encryption\_key\_app\_repository\_secret\_name) | The secret name for the encryption key of the app repository. |
| <a name="output_encryption_key_ingestion_secret_name"></a> [encryption\_key\_ingestion\_secret\_name](#output\_encryption\_key\_ingestion\_secret\_name) | The secret name for the encryption key of the ingestion. |
| <a name="output_encryption_key_node_chat_lxm_secret_name"></a> [encryption\_key\_node\_chat\_lxm\_secret\_name](#output\_encryption\_key\_node\_chat\_lxm\_secret\_name) | The secret name for the encryption key of the node chat LXM. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The principal ID of the Azure Container Registry's managed identity. |
| <a name="output_ingestion_cache_connection_string_1_secret_name"></a> [ingestion\_cache\_connection\_string\_1\_secret\_name](#output\_ingestion\_cache\_connection\_string\_1\_secret\_name) | The secret name for the first ingestion cache connection string. |
| <a name="output_ingestion_cache_connection_string_2_secret_name"></a> [ingestion\_cache\_connection\_string\_2\_secret\_name](#output\_ingestion\_cache\_connection\_string\_2\_secret\_name) | The secret name for the second ingestion cache connection string. |
| <a name="output_ingestion_storage_connection_string_1_secret_name"></a> [ingestion\_storage\_connection\_string\_1\_secret\_name](#output\_ingestion\_storage\_connection\_string\_1\_secret\_name) | The secret name for the first ingestion storage connection string. |
| <a name="output_ingestion_storage_connection_string_2_secret_name"></a> [ingestion\_storage\_connection\_string\_2\_secret\_name](#output\_ingestion\_storage\_connection\_string\_2\_secret\_name) | The secret name for the second ingestion storage connection string. |
| <a name="output_oai_cognitive_account_endpoints_secret_names"></a> [oai\_cognitive\_account\_endpoints\_secret\_names](#output\_oai\_cognitive\_account\_endpoints\_secret\_names) | The secret names for the OpenAI cognitive account endpoints. |
| <a name="output_oai_model_version_endpoints_secret_name"></a> [oai\_model\_version\_endpoints\_secret\_name](#output\_oai\_model\_version\_endpoints\_secret\_name) | The secret name for the OpenAI model version endpoints. |
| <a name="output_psql_database_connection_strings_secret_names"></a> [psql\_database\_connection\_strings\_secret\_names](#output\_psql\_database\_connection\_strings\_secret\_names) | The secret names for the PostgreSQL database connection strings. |
| <a name="output_psql_host_secret_name"></a> [psql\_host\_secret\_name](#output\_psql\_host\_secret\_name) | The secret name for the PostgreSQL host. |
| <a name="output_psql_password_secret_name"></a> [psql\_password\_secret\_name](#output\_psql\_password\_secret\_name) | The secret name for the PostgreSQL password. |
| <a name="output_psql_port_secret_name"></a> [psql\_port\_secret\_name](#output\_psql\_port\_secret\_name) | The secret name for the PostgreSQL port. |
| <a name="output_psql_username_secret_name"></a> [psql\_username\_secret\_name](#output\_psql\_username\_secret\_name) | The secret name for the PostgreSQL username. |
| <a name="output_rabbitmq_password_chat_secret_name"></a> [rabbitmq\_password\_chat\_secret\_name](#output\_rabbitmq\_password\_chat\_secret\_name) | The secret name for the RabbitMQ password for chat. |
| <a name="output_redis_cache_host_secret_name"></a> [redis\_cache\_host\_secret\_name](#output\_redis\_cache\_host\_secret\_name) | The secret name for the Redis cache host. |
| <a name="output_redis_cache_password_secret_name"></a> [redis\_cache\_password\_secret\_name](#output\_redis\_cache\_password\_secret\_name) | The secret name for the Redis cache password. |
| <a name="output_redis_cache_port_secret_name"></a> [redis\_cache\_port\_secret\_name](#output\_redis\_cache\_port\_secret\_name) | The secret name for the Redis cache port. |
| <a name="output_zitadel_db_user_password_secret_name"></a> [zitadel\_db\_user\_password\_secret\_name](#output\_zitadel\_db\_user\_password\_secret\_name) | The secret name for the Zitadel database user password. |
| <a name="output_zitadel_master_key_secret_name"></a> [zitadel\_master\_key\_secret\_name](#output\_zitadel\_master\_key\_secret\_name) | The secret name for the Zitadel master key. |
| <a name="output_zitadel_pat_secret_name"></a> [zitadel\_pat\_secret\_name](#output\_zitadel\_pat\_secret\_name) | n/a |
<!-- END_TF_DOCS -->
