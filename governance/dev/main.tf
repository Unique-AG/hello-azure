resource "azurerm_resource_group" "tfstate" {
  name     = var.resource_group_name
  location = var.tfstate_location
}


module "tfstate_sa" {
  source              = "github.com/unique-ag/terraform-modules.git//modules/azure-storage-account?depth=1&ref=azure-storage-account-2.0.2"
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.tfstate_location
  containers = {
    (var.container_name) = {}
  }
}

resource "azuread_application_registration" "terraform" {
  display_name = "Terraform"
}

resource "azuread_application_federated_identity_credential" "github_actions_terraform_main" {
  application_id = azuread_application_registration.terraform.id
  display_name   = "github-actions-terraform-main"
  description    = "GH actions deploying Azure resources for the `main` branch of hello-azure"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:Unique-AG/hello-azure:ref:refs/heads/main"
}
resource "azuread_application_federated_identity_credential" "github_actions_terraform_env" {
  for_each       = toset(["00-init", "10-pm", "20-wl"])
  application_id = azuread_application_registration.terraform.id
  display_name   = "github-actions-terraform-env-${each.value}"
  description    = "GH actions deploying Azure resources for the `${each.value}` env of hello-azure"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:Unique-AG/hello-azure:environment:${each.value}"
}

resource "azuread_application_federated_identity_credential" "github_actions_terraform_dev" {
  application_id = azuread_application_registration.terraform.id
  display_name   = "github-actions-terraform-dev"
  description    = "GH actions deploying Azure resources for the `dev` branch of hello-azure"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:Unique-AG/hello-azure:ref:refs/heads/dev"
}

resource "azuread_service_principal" "terraform" {
  client_id                    = azuread_application_registration.terraform.client_id
  app_role_assignment_required = false
}

resource "azurerm_role_assignment" "terraform_owner" {
  principal_id         = azuread_service_principal.terraform.object_id
  role_definition_name = "Owner"
  scope                = data.azurerm_subscription.this.id
}

resource "azurerm_role_assignment" "terraform_user_access_admin" {
  principal_id         = azuread_service_principal.terraform.object_id
  role_definition_name = "User Access Administrator"
  scope                = data.azurerm_subscription.this.id
}

data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "msgraph" {
  client_id    = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing = true
}

resource "azuread_app_role_assignment" "read_users" {
  app_role_id         = azuread_service_principal.msgraph.app_role_ids["User.Read.All"]
  principal_object_id = azuread_service_principal.terraform.object_id
  resource_object_id  = azuread_service_principal.msgraph.object_id
}
resource "azuread_app_role_assignment" "read_write_groups" {
  app_role_id         = azuread_service_principal.msgraph.app_role_ids["Group.ReadWrite.All"]
  principal_object_id = azuread_service_principal.terraform.object_id
  resource_object_id  = azuread_service_principal.msgraph.object_id
}
resource "azuread_app_role_assignment" "read_write_role_management" {
  app_role_id         = azuread_service_principal.msgraph.app_role_ids["RoleManagement.ReadWrite.Directory"]
  principal_object_id = azuread_service_principal.terraform.object_id
  resource_object_id  = azuread_service_principal.msgraph.object_id
}
resource "azuread_app_role_assignment" "read_write_application" {
  app_role_id         = azuread_service_principal.msgraph.app_role_ids["Application.ReadWrite.All"]
  principal_object_id = azuread_service_principal.terraform.object_id
  resource_object_id  = azuread_service_principal.msgraph.object_id
}
