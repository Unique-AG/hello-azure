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
| <a name="module_application_registration"></a> [application\_registration](#module\_application\_registration) | github.com/Unique-AG/terraform-modules.git//modules/azure-entra-app-registration | azure-entra-app-registration-2.0.0-rc.2 |

## Resources

| Name | Type |
|------|------|
| [azuread_group.admin_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.devops](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.emergency_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.main_keyvault_secret_writer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.sensitive_data_observer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.telemetry_observer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_federated_identity_credential.afic_workloads](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_resource_group.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.sensitive](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.acrpush_terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_workload_identity_cognitive_services_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.application_gateway_ingres_controller_contributor_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.application_gateway_ingres_controller_reader_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.application_gateway_ingres_controller_vnet_subnet_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cluster_rbac_admin_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cluster_rbac_admin_terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cluster_rbac_admin_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cluster_user_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cluster_user_terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.cluster_user_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.csi_identity_secret_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.csi_identity_secret_reader_main_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.dns_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.ingestion_cache_kv_key_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.ingestion_cache_kv_secrets_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.ingestion_storage_kv_key_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.ingestion_storage_kv_secrets_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kubelet_identity_acr_puller_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kv_access_administrator_terraform_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kv_crypto_officer_terraform_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kv_main_access_administrator_terraform_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kv_main_crypto_officer_terraform_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kv_main_secrets_officer_terraform_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.kv_secrets_officer_terraform_assign](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.main_keyvault_key_reader_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.main_keyvault_secret_manager_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.main_keyvault_secret_manager_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.psql_identity_role_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.telemetry_observer_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.telemetry_observer_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.acr_puller](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.devops_preview](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.emergency_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.sensitive_data_observer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.telemetry_observer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.vnet_subnet_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_user_assigned_identity.aks_workload_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.document_intelligence_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.ingestion_cache_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.ingestion_storage_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.psql_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/application_published_app_ids) | data source |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azuread_service_principal.terraform](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_user.cluster_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azuread_user.gitops_maintainer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azuread_user.main_keyvault_secret_writer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azuread_user.telemetry_observer](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |
| [azurerm_kubernetes_cluster.cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [azurerm_role_definition.acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.grafana_viewer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_role_definition.reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_kubernetes_cluster_group_display_name"></a> [admin\_kubernetes\_cluster\_group\_display\_name](#input\_admin\_kubernetes\_cluster\_group\_display\_name) | Display name for the Admin Kubernetes Cluster group | `string` | `"Admin Kubernetes Cluster"` | no |
| <a name="input_aks_user_assigned_identity_name"></a> [aks\_user\_assigned\_identity\_name](#input\_aks\_user\_assigned\_identity\_name) | The name of the AKS user-assigned identity. | `string` | n/a | yes |
| <a name="input_application_gateway_id"></a> [application\_gateway\_id](#input\_application\_gateway\_id) | The ID of the Application Gateway. | `string` | n/a | yes |
| <a name="input_application_registration_gitops_display_name"></a> [application\_registration\_gitops\_display\_name](#input\_application\_registration\_gitops\_display\_name) | Display name for the GitOps application registration | `string` | n/a | yes |
| <a name="input_application_secret_display_name"></a> [application\_secret\_display\_name](#input\_application\_secret\_display\_name) | Display name for the GitOps application secret | `string` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client ID for authentication. | `string` | n/a | yes |
| <a name="input_cluster_admins"></a> [cluster\_admins](#input\_cluster\_admins) | n/a | `set(string)` | n/a | yes |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of the cluster. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster. | `string` | n/a | yes |
| <a name="input_cluster_workload_identities"></a> [cluster\_workload\_identities](#input\_cluster\_workload\_identities) | Workload Identities to be federated into the cluster. | <pre>map(object({<br/>    name      = string<br/>    namespace = string<br/>  }))</pre> | <pre>{<br/>  "assistants-core": {<br/>    "name": "assistants-core",<br/>    "namespace": "unique"<br/>  },<br/>  "backend-service-chat": {<br/>    "name": "backend-service-chat",<br/>    "namespace": "unique"<br/>  },<br/>  "backend-service-ingestion": {<br/>    "name": "backend-service-ingestion",<br/>    "namespace": "unique"<br/>  },<br/>  "backend-service-ingestion-worker": {<br/>    "name": "backend-service-ingestion-worker",<br/>    "namespace": "unique"<br/>  }<br/>}</pre> | no |
| <a name="input_devops_group_display_name"></a> [devops\_group\_display\_name](#input\_devops\_group\_display\_name) | Display name for the DevOps group | `string` | `"DevOps"` | no |
| <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id) | ID of the DNS zone | `string` | n/a | yes |
| <a name="input_dns_zone_name"></a> [dns\_zone\_name](#input\_dns\_zone\_name) | Name of the DNS zone | `string` | n/a | yes |
| <a name="input_document_intelligence_identity_name"></a> [document\_intelligence\_identity\_name](#input\_document\_intelligence\_identity\_name) | The name of the document intelligence identity. | `string` | n/a | yes |
| <a name="input_emergency_admin_group_display_name"></a> [emergency\_admin\_group\_display\_name](#input\_emergency\_admin\_group\_display\_name) | Display name for the Emergency Admin group | `string` | `"Emergency Admin"` | no |
| <a name="input_gitops_maintainers"></a> [gitops\_maintainers](#input\_gitops\_maintainers) | n/a | `set(string)` | n/a | yes |
| <a name="input_ingestion_cache_identity_name"></a> [ingestion\_cache\_identity\_name](#input\_ingestion\_cache\_identity\_name) | The name of the ingestion cache identity. | `string` | n/a | yes |
| <a name="input_ingestion_storage_identity_name"></a> [ingestion\_storage\_identity\_name](#input\_ingestion\_storage\_identity\_name) | The name of the ingestion storage identity. | `string` | n/a | yes |
| <a name="input_main_keyvault_secret_writer_group_display_name"></a> [main\_keyvault\_secret\_writer\_group\_display\_name](#input\_main\_keyvault\_secret\_writer\_group\_display\_name) | Display name for the Main Key Vault writer group | `string` | `"Main KeyVault writer"` | no |
| <a name="input_main_keyvault_secret_writers"></a> [main\_keyvault\_secret\_writers](#input\_main\_keyvault\_secret\_writers) | n/a | `set(string)` | n/a | yes |
| <a name="input_main_kv_id"></a> [main\_kv\_id](#input\_main\_kv\_id) | The ID of the main key vault. | `string` | n/a | yes |
| <a name="input_psql_user_assigned_identity_name"></a> [psql\_user\_assigned\_identity\_name](#input\_psql\_user\_assigned\_identity\_name) | The name of the PostgreSQL user-assigned identity. | `string` | n/a | yes |
| <a name="input_resource_audit_location"></a> [resource\_audit\_location](#input\_resource\_audit\_location) | The location of audit resource group name. | `string` | `"switzerlandnorth"` | no |
| <a name="input_resource_group_core_location"></a> [resource\_group\_core\_location](#input\_resource\_group\_core\_location) | The location of core resource group name. | `string` | `"switzerlandnorth"` | no |
| <a name="input_resource_group_core_name"></a> [resource\_group\_core\_name](#input\_resource\_group\_core\_name) | The core resource group name. | `string` | `"resource-group-core"` | no |
| <a name="input_resource_group_sensitive_location"></a> [resource\_group\_sensitive\_location](#input\_resource\_group\_sensitive\_location) | The location of sensitive resource group name. | `string` | `"switzerlandnorth"` | no |
| <a name="input_resource_group_sensitive_name"></a> [resource\_group\_sensitive\_name](#input\_resource\_group\_sensitive\_name) | The sensitive resource group name. | `string` | `"resource-group-sensitive"` | no |
| <a name="input_resource_group_vnet_id"></a> [resource\_group\_vnet\_id](#input\_resource\_group\_vnet\_id) | The vnet resource group id. | `string` | n/a | yes |
| <a name="input_resource_vnet_location"></a> [resource\_vnet\_location](#input\_resource\_vnet\_location) | The location of vnet resource group name. | `string` | `"switzerlandnorth"` | no |
| <a name="input_sensitive_data_observer_group_display_name"></a> [sensitive\_data\_observer\_group\_display\_name](#input\_sensitive\_data\_observer\_group\_display\_name) | Display name for the Sensitive Data Observer group | `string` | `"Sensitive Data Observer"` | no |
| <a name="input_sensitive_kv_id"></a> [sensitive\_kv\_id](#input\_sensitive\_kv\_id) | The ID of the sensitive key vault. | `string` | n/a | yes |
| <a name="input_service_principal_display_name"></a> [service\_principal\_display\_name](#input\_service\_principal\_display\_name) | Display name of the Azure AD service principal. | `string` | `"default-service-principal"` | no |
| <a name="input_telemetry_observer_group_display_name"></a> [telemetry\_observer\_group\_display\_name](#input\_telemetry\_observer\_group\_display\_name) | Display name for the Telemetry Observer group | `string` | `"Telemetry Observer"` | no |
| <a name="input_telemetry_observers"></a> [telemetry\_observers](#input\_telemetry\_observers) | n/a | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_workload_identity_client_id"></a> [aks\_workload\_identity\_client\_id](#output\_aks\_workload\_identity\_client\_id) | The client ID of the AKS workload identity. |
| <a name="output_cluster_workload_identities"></a> [cluster\_workload\_identities](#output\_cluster\_workload\_identities) | This output reflects configurations that must then be applied to the workloads in the cluster. The client\_ids are to be used as Managed Identities while the subject must match exactly the Service Accounts Name and Namespace. |
| <a name="output_document_intelligence_user_assigned_identity_id"></a> [document\_intelligence\_user\_assigned\_identity\_id](#output\_document\_intelligence\_user\_assigned\_identity\_id) | The ID of the user-assigned identity for document intelligence. |
| <a name="output_ingestion_cache_user_assigned_identity_id"></a> [ingestion\_cache\_user\_assigned\_identity\_id](#output\_ingestion\_cache\_user\_assigned\_identity\_id) | The ID of the user-assigned identity for ingestion cache. |
| <a name="output_ingestion_storage_user_assigned_identity_id"></a> [ingestion\_storage\_user\_assigned\_identity\_id](#output\_ingestion\_storage\_user\_assigned\_identity\_id) | The ID of the user-assigned identity for ingestion storage. |
| <a name="output_key_vault_secrets_provider_client_id"></a> [key\_vault\_secrets\_provider\_client\_id](#output\_key\_vault\_secrets\_provider\_client\_id) | The client ID of the Key Vault secrets provider. |
| <a name="output_psql_user_assigned_identity_id"></a> [psql\_user\_assigned\_identity\_id](#output\_psql\_user\_assigned\_identity\_id) | The ID of the user-assigned identity for PostgreSQL. |
| <a name="output_resource_group_core_id"></a> [resource\_group\_core\_id](#output\_resource\_group\_core\_id) | The ID of the core resource group. |
| <a name="output_resource_group_core_name"></a> [resource\_group\_core\_name](#output\_resource\_group\_core\_name) | The name of the core resource group. |
| <a name="output_resource_group_sensitive_id"></a> [resource\_group\_sensitive\_id](#output\_resource\_group\_sensitive\_id) | The ID of the sensitive resource group. |
| <a name="output_resource_group_sensitive_name"></a> [resource\_group\_sensitive\_name](#output\_resource\_group\_sensitive\_name) | The name of the sensitive resource group. |
<!-- END_TF_DOCS -->
