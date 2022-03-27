terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<=2.98.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.2"
    }
  }
}

provider "random" {
}

provider "azurerm" {
  features {}

}

data "azurerm_client_config" "current" {}