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
