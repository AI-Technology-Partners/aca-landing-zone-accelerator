# Test terraform syntax
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Test the hub module syntax
module "hub_test" {
  source                                     = "./scenarios/aca-internal/terraform/modules/01-hub"
  workloadName                               = "test"
  environment                                = "dev"
  hubResourceGroupName                       = "test-rg"
  location                                   = "East US"
  vnetAddressPrefixes                        = ["10.0.0.0/24"]
  enableBastion                              = false
  enableFirewall                             = false
  bastionSubnetAddressPrefixes               = ["10.0.0.128/26"]
  gatewaySubnetAddressPrefix                 = "10.0.0.0/27"
  azureFirewallSubnetAddressPrefix           = "10.0.0.64/26"
  azureFirewallSubnetManagementAddressPrefix = "10.0.0.192/26"
  infraSubnetAddressPrefix                   = "10.1.0.0/27"
  tags                                       = {}
}
