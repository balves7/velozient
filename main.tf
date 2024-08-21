terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.44.1"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = "brazilsouth"

  tags = var.tags
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${var.project}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}


####    MODULES DESCLARATION    #####

module "network" {
  source = "./modules/network"

  location = var.location
  tags     = var.tags
}

module "web_vms" {
  source = "./modules/web_vms"

  network_resource_group_name = module.network.network_resource_group_name
  environment                 = var.environment
  location                    = var.location
  vm_size                     = var.vm_size
  web_subnet_id               = module.network.snweb_id
  admin_user                  = var.admin_user
  admin_pass                  = var.admin_pass

}

module "app_vms" {
  source = "./modules/app_vms"

  network_resource_group_name = module.network.network_resource_group_name
  environment                 = var.environment
  location                    = var.location
  vm_size                     = var.vm_size
  app_subnet_id               = module.network.snapp_id
  admin_user                  = var.admin_user
  admin_pass                  = var.admin_pass

}

module "db" {
  source = "./modules/db"

  db_admin_pass = var.db_admin_pass
  db_admin_user = var.db_admin_user
  location      = var.location
  environment   = var.environment
}
