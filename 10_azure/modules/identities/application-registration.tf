locals {
  maintainers_principal_object_ids = [for user in values(data.azuread_user.gitops_maintainer) : user.object_id]
}

resource "azuread_service_principal" "msgraph" {
  client_id    = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing = true
}

module "application_registration" {
  source                           = "github.com/Unique-AG/terraform-modules.git//modules/azure-entra-app-registration?ref=azure-entra-app-registration-2.0.0-rc.2"
  display_name                     = var.application_registration_gitops_display_name 
  keyvault_id                      = var.sensitive_kv_id
  aad-app-secret-display-name      = var.application_secret_display_name
  maintainers_principal_object_ids = local.maintainers_principal_object_ids
  redirect_uris = [
    "https://argo.${var.dns_zone_name}/auth/callback",
  ]
  required_resource_access_list = {
    (data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph) = [
      {
        id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["profile"]
        type = "Scope"
      },
      {
        id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"]
        type = "Scope"
      },
      {
        id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["openid"]
        type = "Scope"
      },
      {
        id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids["email"] 
        type = "Scope"
      },
    ],
  }
}
