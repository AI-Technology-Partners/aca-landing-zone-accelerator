# Configure the Azure provider for local deployment
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.90.0"
    }
  }
  required_version = ">= 1.3.4"

  # Local backend for testing - comment out for remote deployment
  # backend "azurerm" {
  # }
}

provider "azurerm" {
  disable_terraform_partner_id = false
  partner_id                   = "9b4433d6-924a-4c07-b47c-7478619759c7"
  subscription_id              = "f765f607-406e-4772-b256-aa6813e0e163"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
