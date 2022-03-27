
##############################################################################
####################Bastion Host##############################################
##############################################################################

resource "azurerm_public_ip" "bastion" {
  name                = "bastion-pip"
  location            = azurerm_virtual_network.vnet.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_tags             = {}
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = azurerm_virtual_network.vnet.location
  resource_group_name = azurerm_resource_group.vnet-rg.name


  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.Azure_Bastion_Subnet1.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
