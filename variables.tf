variable "tags" {
  description = "List of tags."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Resource name prefix."
  type        = string
  default     = "oneadkv"
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "rg_name" {
  description = "The name of an existing resource group to create the Private Endpoint in."
  type        = string
  default     = ""
}

variable "source_vnet_id" {
  description = "The id of an existing vnet to place a Private Endpoint."
  type        = string
}

variable "source_subnet_id" {
  description = "The id of an existing subnet to place a Private Endpoint."
  type        = string
}

variable "priv_conn_config" {
  description = "Private connection and DNS zone configuration details."
  type = object({
    name_prefix                      = string
    private_connection_resource_id   = string
    private_connection_resource_name = string
    subresource_names                = list(string)
    private_dns_zone_name            = string
  })
  default = {
    name_prefix                      = "",
    private_connection_resource_id   = "",
    private_connection_resource_name = "",
    subresource_names                = [""],
    private_dns_zone_name            = ""
  }
}

variable "ttl" {
  description = "DNS Record TTL."
  type        = number
  default     = 10
}
