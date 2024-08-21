output "web_vm_name" {
    description = "Ouputs the name of VM"
    value = tomap(
        {
            for name, vm in azurerm_virtual_machine.web : name => vm.name
        }   
    )
}

output "web_vm_private_ip" {
    description = "Outputs the private IP of the VM"
    value       = tomap(
        {
            for name, vm in azurerm_network_interface.webnic : name => vm.private_ip_address
        }   
    )
}

output "web_public_ip" {
    description = "Outputs the public IP of web LB"
    value       = azurerm_public_ip.public-ip.ip_address
}