output "app_vm_name" {
    description = "Ouputs the name of VM"
    value = tomap(
        {
            for name, vm in azurerm_virtual_machine.app : name => vm.name
        }   
    )
}

output "app_vm_private_ip" {
    description = "Outputs the private IP of the VM"
    value       = tomap(
        {
            for name, vm in azurerm_network_interface.appnic : name => vm.private_ip_address
        }   
    )
}