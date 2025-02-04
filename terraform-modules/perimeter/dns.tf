resource "azurerm_private_dns_zone" "psql_private_dns_zone" {
  name                = var.psql_private_dns_zone_name
  resource_group_name = var.resource_group_vnet_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "psql-private-dns-zone-vnet-link" {
  name                  = var.azurerm_private_dns_zone_virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.psql_private_dns_zone.name
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
  records             = var.dns_zone_root_records
  tags                = var.tags
}

resource "azurerm_dns_a_record" "adnsar_sub_domains" {
  for_each            = var.dns_zone_sub_domain_records
  name                = each.value.name
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_vnet_name
  ttl                 = 300
  records             = each.value.records
  tags                = var.tags
}
