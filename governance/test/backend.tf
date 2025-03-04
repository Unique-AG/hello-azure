terraform {

    backend "local" {
      path  = "terraform.tfstate"
    }

  # backend "azurerm" {
  #   # The backend configuration gets loaded from config.auto.tfvars
  #   # When running Terraform in GitHub Actions, the provider will detect the ACTIONS_ID_TOKEN_REQUEST_URL and ACTIONS_ID_TOKEN_REQUEST_TOKEN environment variables set by the GitHub Actions runtime
  #   # https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/guides/service_principal_oidc#oidc-token
  # }

}
