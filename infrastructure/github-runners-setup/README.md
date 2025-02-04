# Kubernetes Workloads

This document provides information on deploying Kubernetes workloads. These workloads are defined as Helmfiles in the [helm](helm) directory. Additionally, there are some optional helper steps that can be performed:

1. **[GitHub Runner Setup](github_runner_setup)**: Set up GitHub runners to communicate with the cluster using its VNET.
2. **[Mirror Artifacts](mirror_artifacts)**: Mirror Docker images from both public registries and unique images. Note that Helm charts are not mirrored at this time.
3. **[Terraform-Helm Mapping](terraform-helm-mapping)**: Contains a Python script that maps Terraform outputs from [../infrastructure](../infrastructure) to [Helm parameters file](../helm/terraform-outputs.yaml.jinja). This process is automated in a [deployment pipeline](../.github/workflows/helm.yaml).

## Set Up Private Networking for GitHub Hosted Runners

### How To

1. **Obtain the `databaseId` for Your Organization**: Use a Personal Access Token (PAT) as a bearer token.
    ```bash
    curl -H "Authorization: Bearer BEARER_TOKEN" -X POST \
      -d '{ "query": "query($login: String!) { organization (login: $login) { login databaseId } }" ,
            "variables": {
              "login": "Unique-AG"
            }
          }' \
    https://api.github.com/graphql
    ```

2. **Set the Terraform Variable `github_org_id`**: Use the acquired `databaseId`.
    ```bash
    bearerToken=<<bearer token>>
    orgName="Unique-AG"
    databaseId=$(curl -s -H "Authorization: Bearer $bearerToken" -X POST \
      -d '{ "query": "query($login: String!) { organization (login: $login) { login databaseId } }" ,
            "variables": {
              "login": "'$orgName'"
            }
          }' \
    https://api.github.com/graphql | jq -r '.data.organization.databaseId')
    sed -r -i '' "s/(github_org_id(.*)=\s*).*/\1 $databaseId/" variables.auto.tfvars
    ```

3. **Apply the Terraform Configuration**: The `network_settings_id` will be returned as an output.

As a GitHub admin, perform the following steps through the GitHub UI (ClickOps):

4. **Configure Azure Private Network**:
    - Navigate to `Organization` -> `Settings` -> `Hosted Compute Networking` -> `New network configuration` -> `Azure private network`.
    - Use the Terraform output value of `network_settings_id` as the `Network settings resource ID`.

5. **Add a Runner Group**:
    - Go to `Actions` -> `Runner Groups` -> `New runner group`.
    - Select the network configuration created in step 4 in the `Network Configurations`.
    - Limit access to the runner group to this repository.

6. **Add Runners to the Group**:
    - Open the runner group and add a new GitHub-hosted runner.

7. **Update GitHub Workflow**:
    - Set the `runs-on.group` value to the name of the newly created runner group in the GitHub workflow of this repository.

For more information, see the [official GitHub documentation](https://docs.github.com/en/organizations/managing-organization-settings/configuring-private-networking-for-github-hosted-runners-in-your-organization).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | 2.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=4.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | 2.2.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=4.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.github_network_settings](https://registry.terraform.io/providers/Azure/azapi/2.2.0/docs/resources/resource) | resource |
| [azurerm_network_security_group.github](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_resource_provider_registration.github_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_provider_registration) | resource |
| [azurerm_subnet_network_security_group_association.github_aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_resource_group.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.subnet_github_runners](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subscription.subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The client ID for OIDC | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The resource group name for the tfstate container name | `string` | n/a | yes |
| <a name="input_github_org_id"></a> [github\_org\_id](#input\_github\_org\_id) | n/a | `any` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | The key for the tfstate | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name for the tfstate. | `string` | n/a | yes |
| <a name="input_resource_group_vnet_name"></a> [resource\_group\_vnet\_name](#input\_resource\_group\_vnet\_name) | n/a | `any` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The resource group name for the storage account name | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | n/a | `any` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The UUID ID of the suscription (not the full Azure Resource ID). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The ID of the tenenat | `string` | n/a | yes |
| <a name="input_use_oidc"></a> [use\_oidc](#input\_use\_oidc) | Whether to use OIDC | `bool` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_settings_id"></a> [network\_settings\_id](#output\_network\_settings\_id) | ID of the GitHub.Network/networkSettings resource |
<!-- END_TF_DOCS -->