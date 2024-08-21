resource "azurerm_resource_group" "appvms" {
  name     = "appvms"
  location = var.location

  tags = var.tags
}

resource "azurerm_network_security_group" "sg-app" { 
  name                = "app-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.appvms.name
}

resource "azurerm_network_security_rule" "sg-app-rules" {
  resource_group_name = azurerm_resource_group.appvms.name
  network_security_group_name = azurerm_network_security_group.sg-app.name
    
    for_each = var.app_sg_rules
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

resource "azurerm_network_interface" "appnic" {
  for_each = var.vm_map
    name = "${each.value.name}-nic"
    location = var.location
    resource_group_name = var.network_resource_group_name

    ip_configuration {
      name = "custom-nic-config"
      subnet_id = var.app_subnet_id 
      private_ip_address_allocation = "Dynamic"
    }   
}

resource "azurerm_virtual_machine" "app" {
    for_each = var.vm_map
    name = each.value.name 
    location = var.location
    resource_group_name = azurerm_resource_group.appvms.name
    network_interface_ids = [azurerm_network_interface.appnic[each.key].id]
    vm_size               = var.vm_size

    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true

    storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
    }

    storage_os_disk {
      name = "osdisk${each.value.name}"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile {
      computer_name  = "${each.value.name}"
      admin_username = var.admin_user
      admin_password = var.admin_pass 
    }

    os_profile_linux_config {
      disable_password_authentication = false
    }

    tags = merge(var.tags, {
        Name = "${each.value.name}"
    })
}