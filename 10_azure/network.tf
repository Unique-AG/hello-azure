resource "azurerm_resource_group" "vnet" {
  name     = "rg-vnet-002"
  location = "swedencentral"
}

# -- use https://www.davidc.net/sites/default/subnets/subnets.html to calculate the CIDR ranges
module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "v0.7.1"

  name                = "vnet-001"
  address_space       = ["10.201.0.0/22"]
  location            = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name
  # -- https://www.davidc.net/sites/default/subnets/subnets.html?network=10.201.0.0&mask=22&division=21.5f4620
  subnets = {
    "snet-aks-pods" = {
      name             = "snet-aks-nodes"
      address_prefixes = ["10.201.0.0/23"]
    }
    "snet-aks-nodes" = {
      name             = "snet-aks-nodes"
      address_prefixes = ["10.201.2.0/24"]
    }
    "snet-agw" = {
      name             = "snet-application-gateway"
      address_prefixes = ["10.201.3.0/28"]
    }
    "snet-cognitive" = {
      name             = "snet-cognitive-services"
      address_prefixes = ["10.201.3.16/28"]
    }
    "snet-kv" = {
      name             = "snet-key-vault"
      address_prefixes = ["10.201.3.32/28"]
    }
    "snet-psql" = {
      name             = "snet-postgres"
      address_prefixes = ["10.201.3.48/28"]
      delegation = [{
        name = "psql-delegation"
        service_delegation = {
          name = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
          ]
        }
      }]
    }
    "snet-redis" = {
      name             = "snet-redis"
      address_prefixes = ["10.201.3.64/28"]
    }
    "snet-storage" = {
      name             = "snet-storage"
      address_prefixes = ["10.201.3.80/28"]
    }
    "snet-github" = {
      name             = "snet-github-runners"
      address_prefixes = ["10.201.3.96/28"]
      delegation = [{
        name = "delegation"
        service_delegation = {
          name = "GitHub.Network/networkSettings"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
          ]
        }
      }]
    }
  }
}
