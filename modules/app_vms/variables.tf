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

variable "app_subnet_id" {
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
      name = "appvm1"
      
    }
  }
}

variable "app_sg_rules" {
  description = "Security Group rules for app resource group"
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
     dst_port     = "8080"
     src_address  = "10.0.0.0/16"
     dst_address  = "*" 
    }
  }
}