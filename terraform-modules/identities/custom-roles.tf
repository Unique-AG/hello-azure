resource "azurerm_role_definition" "emergency_admin" {
  name  = "Emergency Admin"
  scope = data.azurerm_subscription.current.id

  permissions {
    actions          = data.azurerm_role_definition.contributor.permissions[0].actions
    not_actions      = data.azurerm_role_definition.contributor.permissions[0].not_actions
    data_actions     = data.azurerm_role_definition.contributor.permissions[0].data_actions
    not_data_actions = data.azurerm_role_definition.contributor.permissions[0].not_data_actions
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id
  ]
}

resource "azurerm_role_definition" "devops_preview" {
  name  = "DevOps"
  scope = data.azurerm_subscription.current.id

  permissions {
    actions          = data.azurerm_role_definition.contributor.permissions[0].actions
    not_actions      = data.azurerm_role_definition.contributor.permissions[0].not_actions
    data_actions     = data.azurerm_role_definition.contributor.permissions[0].data_actions
    not_data_actions = data.azurerm_role_definition.contributor.permissions[0].not_data_actions
  }

  assignable_scopes = [
    azurerm_resource_group.core.id,
    azurerm_resource_group.sensitive.id
  ]
}

resource "azurerm_role_definition" "telemetry_observer" {
  name  = "Telemetry Observer"
  scope = data.azurerm_subscription.current.id

  permissions {
    actions          = data.azurerm_role_definition.reader.permissions[0].actions
    not_actions      = data.azurerm_role_definition.reader.permissions[0].not_actions
    data_actions     = data.azurerm_role_definition.reader.permissions[0].data_actions
    not_data_actions = data.azurerm_role_definition.reader.permissions[0].not_data_actions
  }

  assignable_scopes = [
    azurerm_resource_group.core.id,
    var.resource_group_vnet_id
  ]
}

resource "azurerm_role_definition" "sensitive_data_observer" {
  name  = "Sensitive Data Observer"
  scope = data.azurerm_subscription.current.id

  permissions {
    actions          = data.azurerm_role_definition.reader.permissions[0].actions
    not_actions      = data.azurerm_role_definition.reader.permissions[0].not_actions
    data_actions     = data.azurerm_role_definition.reader.permissions[0].data_actions
    not_data_actions = data.azurerm_role_definition.reader.permissions[0].not_data_actions
  }

  assignable_scopes = [
    azurerm_resource_group.sensitive.id
  ]
}

resource "azurerm_role_definition" "vnet_subnet_access" {
  name  = "VNet Subnet Access (Preview)"
  scope = data.azurerm_subscription.current.id

  permissions {
    actions = [
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/read"
    ]
    not_actions      = []
    data_actions     = []
    not_data_actions = []
  }

  assignable_scopes = [
    var.resource_group_vnet_id
  ]
}

resource "azurerm_role_definition" "acr_puller" {
  name  = "AcrPull Principals"
  scope = data.azurerm_subscription.current.id

  permissions {
    actions          = concat(["Microsoft.ContainerRegistry/registries/read"], tolist(data.azurerm_role_definition.acr_pull.permissions[0].actions))
    not_actions      = data.azurerm_role_definition.acr_pull.permissions[0].not_actions
    data_actions     = data.azurerm_role_definition.acr_pull.permissions[0].data_actions
    not_data_actions = data.azurerm_role_definition.acr_pull.permissions[0].not_data_actions
  }

  assignable_scopes = [
    azurerm_resource_group.core.id
  ]
}
