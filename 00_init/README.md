# Step 0. Initializing the tenant

## What is the purpose of this step

> :information_source: **Note:** In this step, a remote Terraform state is being set up in Azure. This setup may not align with your specific requirements, so be prepared to make any necessary adjustments.

This step will allow us to automate all the further deployments
In a high overview, in this init the following are created:
- Storage account for Terrafrom state (`tfstate`)
- Azure Application
- [Federated credentials](https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azp) that will allow Terraform to [authenticate to Azure using a Service Principal with Open ID Connect](https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/guides/service_principal_oidc). It allows GitHub actions on the branch `main` to deploy and manage resource for this subscription. [More about Federated identity credentils](https://learn.microsoft.com/en-us/graph/api/resources/federatedidentitycredentials-overview?view=graph-rest-1.0)
- Service principal and role mapping

With this setup, the GitHub's `main` and `dev` branches will have right to access the tenant with `Contributor` role without defining any credentials in the repository. The OIDC token (JWT) that is created in the GitHub actions will be exchanged for Azure acess token. Only tokens for `main` and `dev` branches will be allowed to be exchanged based on the [subject of the generated token](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/about-security-hardening-with-openid-connect#filtering-for-a-specific-branch)
E.g.:
```
resource "azuread_application_federated_identity_credential" "github_actions_terraform_main" {
  ...
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:Unique-AG/hello-azure:ref:refs/heads/main"
}
```

## Prerequisites
Before proceeding, ensure you have the following:
- Tenant
- Subscription

## Manual actions
The process consists of 2 phases - (1) initialization with local state file and (2) migrating the local state file to remote storage
### Phase 1
First Terraform has to be run with local state file, since there is no remote storage for the state. For this, go to `backend.tf` and enable local backend:
```hcl
terraform {

   backend "local" {
     path  = "terraform.tfstate"
   }

#  backend "azurerm" {
#   ...
#  }

}
```
login manually to your tenant:
```bash
az login --tenant <<TENANT_ID>>
```
and then apply the Terraform changes:
```bash
terraform init
terraform apply
```

Next, we will have to populate the `client_id` in `config.auto.tfvars` from the newly created application:
```bash
var_value=$(terraform output client_id)
sed -r -i '' "s/(client_id(.*)=\s*).*/\1 $var_value/" config.auto.tfvars
```
### Phase 2
We can switch to the `azurerm` backend:
```hcl
terraform {

#   backend "local" {
#     path  = "terraform.tfstate"
#   }

  backend "azurerm" {
    ...
  }

}
```
Now let's migrate the local state to newly created storage in Azure:

```bash
terraform init -backend-config=variables.auto.tfvars -migrate-state
```
Now we are ready to make all the changes from within CI pipelines.

# Terraform resources

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 3.0.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.0.1 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tfstate_sa"></a> [tfstate\_sa](#module\_tfstate\_sa) | github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-2.0.2 | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_app_role_assignment.read_users](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/app_role_assignment) | resource |
| [azuread_app_role_assignment.read_write_application](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/app_role_assignment) | resource |
| [azuread_app_role_assignment.read_write_groups](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/app_role_assignment) | resource |
| [azuread_app_role_assignment.read_write_role_management](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/app_role_assignment) | resource |
| [azuread_application_federated_identity_credential.github_actions_terraform_dev](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_federated_identity_credential.github_actions_terraform_env](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_federated_identity_credential.github_actions_terraform_main](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_registration.terraform](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/application_registration) | resource |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/service_principal) | resource |
| [azuread_service_principal.terraform](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/resources/service_principal) | resource |
| [azurerm_resource_group.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.terraform_owner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.terraform_user_access_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/3.0.1/docs/data-sources/application_published_app_ids) | data source |
| [azurerm_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client ID for OIDC | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The resource group name for the tfstate container name | `string` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The key for the tfstate | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name for the tfstate. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The resource group name for the storage account name | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The UUID ID of the suscription (not the full Azure Resource ID). | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The ID of the tenenat | `string` | n/a | yes |
| <a name="input_tfstate_location"></a> [tfstate\_location](#input\_tfstate\_location) | The location for the tfstate resources | `string` | n/a | yes |
| <a name="input_use_oidc"></a> [use\_oidc](#input\_use\_oidc) | Whether to use OIDC | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
<!-- END_TF_DOCS -->
