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

variable "db_admin_user" {
    description = "Admin Username"
    type        = string
    sensitive = true 
}

variable "db_admin_pass" {
    description = "Admin password"
    type        = string
    sensitive = true
}

variable "db_sg_rules" {
  description = "Security Group rules for db resource group"
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
     dst_port     = "1433"
     src_address  = "10.0.0.0/16"
     dst_address  = "*" 
    }
  }
}