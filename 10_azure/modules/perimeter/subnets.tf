locals {
  subnets = {
    subnet_redis = {
      name           = var.subnet_redis_name
      address_prefix = "10.0.0.0/24"
    }
    subnet_storage = {
      name           = var.subnet_storage_name
      address_prefix = "10.0.1.0/24"
    }
    subnet_cognitive_services = {
      name           = var.subnet_cognitive_services_name
      address_prefix = "10.0.2.0/24"
    }
    subnet_key_vault = {
      name           = var.subnet_key_vault_name
      address_prefix = "10.0.3.0/24"
    }
    subnet_aks_nodes = {
      name           = var.subnet_aks_nodes_name
      address_prefix = "10.0.4.0/24"
    }
    subnet_application_gateway = {
      name           = var.subnet_application_gateway_name
      address_prefix = "10.0.5.0/24"
    }
  }
}

resource "azurerm_subnet" "subnets" {
  for_each             = local.subnets
  name                 = each.value.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.vnet.name
  address_prefixes     = [each.value.address_prefix]
}

resource "azurerm_subnet" "postgres_subnet" {
  name                 = var.subnet_psql_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.vnet.name
  address_prefixes     = ["10.0.6.0/24"]
  delegation {
    name = "psql-delegation"

    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}
