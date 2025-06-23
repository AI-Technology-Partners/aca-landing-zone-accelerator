// AITP's Azure Container Apps Landing Zone Configuration for LibreChat
// Simplified version with unnecessary components removed to reduce complexity
// The name of the workloard that is being deployed. Up to 10 characters long. This wil be used as part of the naming convention (i.e. as defined here: https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) 
workloadName = "lzaaca"
//The name of the environment (e.g. "dev", "test", "prod", "preprod", "staging", "uat", "dr", "qa"). Up to 8 characters long.
environment = "dev"
tags = {
  Organization = "AITP"
  Purpose      = "LibreChat-Deployment"
  Architecture = "Simplified"
}

# Simplified configuration - removed unnecessary components
enableFirewall = false # NSGs provide adequate security for LibreChat deployment

hubVnetAddressPrefixes     = ["10.0.0.0/24"]
gatewaySubnetAddressPrefix = "10.0.0.0/27"
# Still need firewall subnets defined even if not used (due to module dependencies)
azureFirewallSubnetAddressPrefix           = "10.0.0.64/26"
bastionSubnetAddressPrefixes               = ["10.0.0.128/26"]
azureFirewallSubnetManagementAddressPrefix = "10.0.0.192/26"

spokeVnetAddressPrefixes = ["10.1.0.0/22"]
# Removed jumpbox subnet - no VM needed
infraSubnetAddressPrefix            = "10.1.0.0/27"
privateEndpointsSubnetAddressPrefix = "10.1.2.0/27"
# Application Gateway subnet removed - not using App Gateway

enableBastion = false
# Removed VM configuration - no management VM needed for LibreChat
// vmSize                   = "Standard_B2ms"
// vmAdminUsername          = "vmadmin"
// vmAdminPassword          = "@Aa123456789"
// vmLinuxSshAuthorizedKeys = "<Your SSH public key>"
// vmJumpboxOSType          = "Linux"
infraSubnetName = "snet-infra"

deployHelloWorldSample              = true
clientIP                            = "<Your computer's IP address>"
supportingResourceGroupName         = "supporting-services"
aRecords                            = []
containerRegistryPullRoleAssignment = "acrRoleAssignment"
keyVaultPullRoleAssignment          = "keyVaultRoleAssignment"
appInsightsName                     = "appInsightsAca"
helloWorldContainerAppName          = "ca-hello-world"
# Application Gateway certificate configuration removed - not using App Gateway

workloadProfiles = [{
  name                  = "general-purpose"
  workload_profile_type = "D4"
  minimum_count         = 1
  maximum_count         = 3
}]
