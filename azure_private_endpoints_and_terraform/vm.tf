resource "random_string" "vm_password" {
  length  = 12
  special = true
}

resource "azurerm_resource_group" "vm-rg" {
  name     = "vm-rg"
  location = "eastUS2"
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-password"
  value        = random_string.vm_password.result
  key_vault_id = azurerm_key_vault.main.id
}



resource "azurerm_linux_virtual_machine" "main" {
  name                            = "jumpbox"
  resource_group_name             = azurerm_resource_group.vm-rg.name
  location                        = azurerm_resource_group.vm-rg.location
  disable_password_authentication = false
  size                            = "Standard_F2"
  admin_username                  = "adminuser"

  admin_password = azurerm_key_vault_secret.vm_password.value
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  depends_on = [azurerm_key_vault.main, azurerm_key_vault_secret.vm_password, azurerm_role_assignment.terraform_spn]
}

resource "azurerm_network_interface" "main" {
  name                = "jumpbox-nic"
  location            = azurerm_resource_group.vm-rg.location
  resource_group_name = azurerm_resource_group.vm-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

