resource "azurerm_resource_group" "vnet-rg" {
  name     = "vnet-rg"
  location = "eastUS2"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "eastus2-vnet"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.vnet-rg.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "Subnet1" {
  name                 = "Subnet1"
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.1.0/24"]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet" "PE_Subnet1" {
  name                                           = "PE_Subnet1"
  resource_group_name                            = azurerm_resource_group.vnet-rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = ["10.1.2.0/24"]
  enforce_private_link_endpoint_network_policies = true
  depends_on                                     = [azurerm_virtual_network.vnet]
}

###Here's our private dns links #####
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_network_links" {
  for_each              = local.private_dns_zones
  name                  = "${azurerm_virtual_network.vnet.name}-link"
  resource_group_name   = azurerm_resource_group.dns-rg.name
  private_dns_zone_name = each.value
  virtual_network_id    = azurerm_virtual_network.vnet.id
  depends_on            = [azurerm_private_dns_zone.private_dns_zones]
}