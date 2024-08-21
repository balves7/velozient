variable "tags" {
  description = "Tags to apply to all resources"
  type = map(string)
  default = {}
}

variable "location" {
  description = "Default Project location"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}


variable "network_resource_group_name" {
    description = "gets resource group name from Network module"
    type        = string
}

variable "web_subnet_id" {
    description = "gets web subnet id from Network module"
    type        = string
}

variable "vm_size" {
    description = "VM size"
    type        = string
}

variable "admin_user" {
    description = "Admin Username"
    type        = string
    sensitive = true 
}

variable "admin_pass" {
    description = "Admin password"
    type        = string
    sensitive = true
}

variable "vm_map" {
  type = map(object({
    name = string
  }))
  default = {
    "vm1" = {
      name = "webvm1"
      
    }
    "vm2" = {
      name = "webvm2"
    } 
  }
}

variable "web_sg_rules" {
  description = "Security Group rules for web resource group"
  type = map(object ({
    name = string
    priority = number
    direction = string
    access =  string
    protocol = string
    src_port = string
    dst_port = string
    src_address = string
    dst_address = string
    }))
  default = {
    rule1 = {
     name         = "rule1"
     priority     = 100
     direction    = "Inbound"
     access       = "Allow"
     protocol     = "Tcp"
     src_port     = "*"
     dst_port     = "443"
     src_address  = "0.0.0.0/0"
     dst_address  = "*" 
    },
    rule2 = {
     name         = "rule2"
     priority     = 101
     direction    = "Inbound"
     access       = "Allow"
     protocol     = "Tcp"
     src_port     = "*"
     dst_port     = "80"
     src_address  = "0.0.0.0/0"
     dst_address  = "*" 
    }
  }
}