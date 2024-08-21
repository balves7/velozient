variable "tags" {
  description = "Common Project tags"
  type        = map(string)
  default = {
    Project   = "Velozient"
    Managedby = "Terraform"
  }
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "project" {
  description = "Customer Name"
  type        = string
  default     = "velozient"
}

variable "location" {
  description = "Default Project location"
  type        = string
  default     = "brazilsouth"
}

variable "resource_group_name" {
  description = "Project resource group name"
  type        = string
  default     = ""
}

###       VMS VARIABLES DECLARATION       ###

variable "vm_size" {
  description = "VM size"
  type        = string
}

variable "admin_user" {
  description = "Admin Username"
  type        = string
  sensitive   = true
}

variable "admin_pass" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

###       SQLDB VARIABLES DECLARATION       ###
variable "db_admin_user" {
  description = "Admin Username"
  type        = string
  sensitive   = true
}

variable "db_admin_pass" {
  description = "Admin password"
  type        = string
  sensitive   = true
}