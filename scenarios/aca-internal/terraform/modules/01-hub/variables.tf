
variable "workloadName" {
  type = string
  validation {
    condition     = length(var.workloadName) >= 2 && length(var.workloadName) <= 10
    error_message = "Name must be greater at least 2 characters and not greater than 10."
  }
}

variable "environment" {
  type = string
  validation {
    condition     = length(var.environment) <= 8
    error_message = "Environment name can't be greater than 8 characters long."
  }
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "hubResourceGroupName" {}

variable "tags" {}

variable "vnetAddressPrefixes" {}

variable "enableBastion" {
  default = false
  type    = bool
  description = "Enable Azure Bastion deployment. Set to false to reduce costs (~$140/month savings)"
}

variable "enableFirewall" {
  default = false
  type    = bool
  description = "Enable Azure Firewall deployment. Set to false to reduce costs (~$700/month savings)"
}

variable "bastionSubnetAddressPrefixes" {}

variable "ddosProtectionPlanId" {
  default = null
  type    = string
}

variable "securityRules" {
  default = []
}

variable "gatewaySubnetName" {
  default = "GatewaySubnet"
  type    = string
}

variable "gatewaySubnetAddressPrefix" {}

variable "azureFirewallSubnetName" {
  default = "AzureFirewallSubnet"
  type    = string
}

variable "azureFirewallSubnetAddressPrefix" {}

variable "azureFirewallSubnetManagementName" {
  default = "AzureFirewallManagementSubnet" # must use this name for Firewall Basic SKU
  type    = string
}

variable "azureFirewallSubnetManagementAddressPrefix" {}

variable "infraSubnetAddressPrefix" {}
