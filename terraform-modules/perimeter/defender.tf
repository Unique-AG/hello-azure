module "defender" {
  source          = "github.com/unique-ag/terraform-modules.git//modules/azure-defender?depth=1&ref=azure-defender-2.0.0-rc.1"
  subscription_id = data.azurerm_subscription.current.id
  security_contact_settings = {
    email = "security-events@unique.ch"
  }
}
