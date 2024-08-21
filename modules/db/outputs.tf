output "sql_server_fqdn" {
    description = "Outputs the fqdn of sql server"
    value = azurerm_mssql_server.sqldbserver.fully_qualified_domain_name
}
