locals {
  private_dns_zones = {
    psql = {
      zone_name = var.psql_private_dns_zone_name
      link_name = var.azurerm_private_dns_zone_virtual_network_link_name
    }
    storage = {
      zone_name = var.storage_private_dns_zone_name 
      link_name = var.azurerm_storage_private_dns_zone_virtual_network_link_name
    }
    redis = {
      zone_name = var.redis_private_dns_zone_name
      link_name = var.azurerm_redis_private_dns_zone_virtual_network_link_name
    }
    cognitive_services = {
      zone_name = var.cognitive_services_private_dns_zone_name
      link_name = var.azurerm_cognitive_services_private_dns_zone_virtual_network_link_name
    }
    aoi = {
      zone_name = var.aoi_private_dns_zone_name
      link_name = var.azurerm_aoi_private_dns_zone_virtual_network_link_name
    }
  }
}

resource "azurerm_private_dns_zone" "private_dns_zones" {
  for_each            = local.private_dns_zones
  name                = each.value.zone_name
  resource_group_name = var.resource_group_vnet_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_links" {
  for_each              = local.private_dns_zones
  name                  = each.value.link_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zones[each.key].name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_vnet_name
}


resource "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_vnet_name
  tags                = var.tags
}

resource "azurerm_dns_a_record" "adnsar_root" {
  name                = "@"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_vnet_name
  ttl                 = 300
  records             = [azurerm_public_ip.load_balancer_public_ip.ip_address]
  tags                = var.tags
}

resource "azurerm_dns_a_record" "adnsar_sub_domains" {
  # for_each            = var.dns_zone_sub_domain_records
  name                = "*"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_vnet_name
  ttl                 = 300
  records             = [azurerm_public_ip.load_balancer_public_ip.ip_address]
  tags                = var.tags
}