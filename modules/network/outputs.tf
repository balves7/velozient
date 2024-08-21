output "vnet_id" {
    description = "vnet id to share between modules"
    value       = azurerm_virtual_network.vnet.id
}

output "snweb_id" {
    description = "subnet id to share between modules"
    value       = azurerm_subnet.sn-web.id
}

output "sndb_id" {
    description = "subnet id to share between modules"
    value       = azurerm_subnet.sn-db.id
}

output "snapp_id" {
    description = "subnet id to share between modules"
    value       = azurerm_subnet.sn-app.id
}

output "network_resource_group_name" {
    description = "resource group name to share between modules"
    value       = azurerm_resource_group.network.name 
}