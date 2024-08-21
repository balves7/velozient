resource "azurerm_resource_group" "rgdb" {
  name     = "rgdb"
  location = var.location
}

resource "azurerm_mssql_server" "sqldbserver" {
  name                         = "bebsqldbserver"
  resource_group_name          = azurerm_resource_group.rgdb.name
  location                     = azurerm_resource_group.rgdb.location
  version                      = "12.0"
  administrator_login          = var.db_admin_user
  administrator_login_password = var.db_admin_pass

  tags = merge(var.tags, {
    Name = "bebsqldbserver"
  })
}

resource "azurerm_storage_account" "dbsa" {
  name                     = "bebdbsa"
  resource_group_name      = azurerm_resource_group.rgdb.name
  location                 = azurerm_resource_group.rgdb.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_database" "sqldb" {
  name                = "bebsqldb"
  server_id           = azurerm_mssql_server.sqldbserver.id

  tags = merge(var.tags, {
    Name = "bebsqldb"
  })

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_network_security_group" "sg-db" { 
  name                = "db-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgdb.name
}

resource "azurerm_network_security_rule" "sg-db-rules" {
  resource_group_name = azurerm_resource_group.rgdb.name
  network_security_group_name = azurerm_network_security_group.sg-db.name
    
    for_each = var.db_sg_rules
      name  = "${each.value.name}"
      priority = "${each.value.priority}"
      direction = "${each.value.direction}"
      access    = each.value.access
      protocol  = each.value.protocol
      source_port_range = each.value.src_port
      destination_port_range = each.value.dst_port
      source_address_prefix = each.value.src_address
      destination_address_prefix = each.value.dst_address
      
}