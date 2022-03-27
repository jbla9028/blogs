locals {
  private_dns_zones = {
    azure-automation-net              = "privatelink.azure-automation.net"
    database-windows-net              = "privatelink.database.windows.net"
    privatelink-blob-core-windows-net = "privatelink.blob.core.windows.net"
    privatelink-vaultcore-azure-net   = "privatelink.vaultcore.azure.net"
  }
}

resource "azurerm_resource_group" "dns-rg" {
  name     = "dns-rg"
  location = "eastUS2"
}

resource "azurerm_private_dns_zone" "private_dns_zones" {
  for_each            = local.private_dns_zones
  name                = each.value
  resource_group_name = azurerm_resource_group.dns-rg.name
}

