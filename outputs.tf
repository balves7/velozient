output "app_vm_name" {
    value = module.app_vms.app_vm_name
}
output "app_vm_private_ip" {
    value = module.app_vms.app_vm_private_ip
}

output "web_vm_name" {
    value = module.web_vms.web_vm_name
}

output "web_vm_private_ip" {
    value = module.web_vms.web_vm_private_ip
}

output "web_public_ip" {
    value = module.web_vms.web_public_ip
}

output "sql_server_fqdn" {
    value = module.db.sql_server_fqdn
}