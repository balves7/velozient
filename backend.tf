terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatevelozient"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}