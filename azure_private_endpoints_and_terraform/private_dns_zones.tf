locals {
  private_dns_zones = {
    azure-automation-net                        = "privatelink.azure-automation.net"
    database-windows-net                        = "privatelink.database.windows.net"
    privatelink-sql-azuresynapse-net            = "privatelink.sql.azuresynapse.net"
    privatelink-dev-azuresynapse-net            = "privatelink.dev.azuresynapse.net"
    privatelink-blob-core-windows-net           = "privatelink.blob.core.windows.net"
    privatelink-table-core-windows-net          = "privatelink.table.core.windows.net"
    privatelink-queue-core-windows-net          = "privatelink.queue.core.windows.net"
    privatelink-file-core-windows-net           = "privatelink.file.core.windows.net"
    privatelink-web-core-windows-net            = "privatelink.web.core.windows.net"
    privatelink-dfs-core-windows-net            = "privatelink.dfs.core.windows.net"
    privatelink-documents-azure-com             = "privatelink.documents.azure.com"
    privatelink-mongo-cosmos-azure-com          = "privatelink.mongo.cosmos.azure.com"
    privatelink-cassandra-cosmos-azure-com      = "privatelink.cassandra.cosmos.azure.com"
    privatelink-gremlin-cosmos-azure-com        = "privatelink.gremlin.cosmos.azure.com"
    privatelink-table-cosmos-azure-com          = "privatelink.table.cosmos.azure.com"
    privatelink-eastus2-batch-azure-com         = "privatelink.eastus2.batch.azure.com"
    privatelink-postgres-database-azure-com     = "privatelink.postgres.database.azure.com"
    privatelink-mysql-database-azure-com        = "privatelink.mysql.database.azure.com"
    privatelink-mysql-database-azure-com        = "privatelink.mariadb.database.azure.com"
    privatelink-vaultcore-azure-net             = "privatelink.vaultcore.azure.net"
    privatelink-eastus2-azmk8s-io               = "privatelink.eastus2.azmk8s.io"
    privatelink-search-windows-net              = "privatelink.search.windows.net"
    privatelink-azurecr-io                      = "privatelink.azurecr.io"
    privatelink-azconfig-io                     = "privatelink.azconfig.io"
    privatelink-siterecovery-windowsazure-com   = "privatelink.siterecovery.windowsazure.com"
    privatelink-servicebus-windows-net          = "privatelink.servicebus.windows.net"
    privatelink-eastus2-backup-windowsazure-com = "privatelink.eastus2.backup.windowsazure.com"
    privatelink-siterecovery-windowsazure-com   = "privatelink.siterecovery.windowsazure.com"
    privatelink-servicebus-windows-net          = "privatelink.servicebus.windows.net"
    privatelink-azure-devices-net               = "privatelink.azure-devices.net"
    privatelink-eventgrid-azure-net             = "privatelink.eventgrid.azure.net"
    privatelink-azurewebsites-net               = "privatelink.azurewebsites.net"
    privatelink-api-azureml-ms                  = "privatelink.api.azureml.ms"
    privatelink-notebooks-azure-net             = "privatelink.notebooks.azure.net"
    privatelink-service-signalr-net             = "privatelink.service.signalr.net"
    privatelink-monitor-azure-com               = "privatelink.monitor.azure.com"
    privatelink-oms-opinsights-azure-com        = "privatelink.oms.opinsights.azure.com"
    privatelink-agentsvc-azure-automation-net   = "privatelink.agentsvc.azure-automation.net"
    privatelink-cognitiveservices-azure-com     = "privatelink.cognitiveservices.azure.com"
    privatelink-afs-azure-net                   = "privatelink.afs.azure.net"
    privatelink-datafactory-azure-net           = "privatelink.datafactory.azure.net"
    privatelink-adf-azure-com                   = "privatelink.adf.azure.com"
    privatelink-redis-cache-windows-net         = "privatelink.redis.cache.windows.net"
    privatelink-redisenterprise-cache-azure-net = "privatelink.redisenterprise.cache.azure.net"
    privatelink-purview-azure-com               = "privatelink.purview.azure.com"
    privatelink-purviewstudio-azure-com         = "privatelink.purviewstudio.azure.com"
    privatelink-digitaltwins-azure-net          = "privatelink.digitaltwins.azure.net"
    privatelink-azurehdinsight-net              = "privatelink.azurehdinsight.net"
    privatelink-ods-opinsights-azure-com        = "privatelink.ods.opinsights.azure.com"

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

