```
locals {
  location = "East US"
  tags = {
    Environment = "dev"
    Project     = "dev"
  }
}

module "pe" {
  source = "git::git@github.com:michalswi/pe.git?ref=main"

  location = local.location
  tags     = local.tags

  rg_name          = "<existing_rg_name>"
  source_vnet_id   = "<existing_source_vnet_id>"
  source_subnet_id = "<existing_source_subnet_id>"

  priv_conn_config = {
    name_prefix                      = "e.g. keyvault"
    private_connection_resource_id   = "e.g. <keyvault_id>"
    private_connection_resource_name = "e.g. <keyvault_name>"
    subresource_names                = ["e.g. vault"]
    private_dns_zone_name            = "e.g. privatelink.vaultcore.azure.net"
  }
}
```
