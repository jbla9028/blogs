resource "azurerm_resource_group" "kv-rg" {
  name     = "kv-rg"
  location = "eastUS2"
}


resource "random_string" "random" {
  length  = 4
  special = false
}

resource "azurerm_key_vault" "main" {
  name                        = "kveus2-${random_string.random.result}"
  location                    = azurerm_resource_group.kv-rg.location
  resource_group_name         = azurerm_resource_group.kv-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
}

resource "azurerm_private_endpoint" "main" {
  name                = "${azurerm_key_vault.main.name}-pe"
  resource_group_name = azurerm_resource_group.kv-rg.name
  location            = azurerm_resource_group.kv-rg.location
  subnet_id           = azurerm_subnet.PE_Subnet1.id
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zones["privatelink-vaultcore-azure-net"].id]
  }
  private_service_connection {
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.main.id
    name                           = "${azurerm_key_vault.main.name}-psc"
    subresource_names = ["vault"]
  }
  depends_on = [azurerm_key_vault.main]
}