locals {
  tags             = var.tags
  name             = var.name
  location         = var.location
  rg_name          = var.rg_name
  subnet_id        = var.source_subnet_id
  vnet_id          = var.source_vnet_id
  priv_conn_config = var.priv_conn_config
  ttl              = var.ttl
}

# private endpoint
resource "azurerm_private_endpoint" "this" {
  name                = "${local.name}-pe"
  location            = local.location
  resource_group_name = local.rg_name
  subnet_id           = local.subnet_id

  private_service_connection {
    name                           = "${local.priv_conn_config.name_prefix}-privatelink"
    private_connection_resource_id = local.priv_conn_config.private_connection_resource_id
    subresource_names              = local.priv_conn_config.subresource_names
    is_manual_connection           = false
  }
}

# private DNS Zone for a resource e.g. Key Vault (privatelink.vaultcore.azure.net)
resource "azurerm_private_dns_zone" "this" {
  name                = local.priv_conn_config.private_dns_zone_name
  resource_group_name = local.rg_name
}

# associate DNS Zone with VNet
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${local.name}-dns-link"
  resource_group_name   = local.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = local.vnet_id
}

# Private DNS Record for a resource e.g. Key Vault
resource "azurerm_private_dns_a_record" "this" {
  name                = local.priv_conn_config.private_connection_resource_name
  zone_name           = azurerm_private_dns_zone.this.name
  resource_group_name = local.rg_name
  ttl                 = local.ttl
  records = [
    azurerm_private_endpoint.this.private_dns_zone_configs[0].ip_address,
  ]
}
