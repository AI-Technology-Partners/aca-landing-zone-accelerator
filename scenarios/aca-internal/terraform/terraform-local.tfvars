# AITP LibreChat Azure Container Apps - Local Testing Configuration
# This is a simplified configuration for manual deployment testing

# Basic settings
workloadName = "aitptest"  # Short name for testing
environment  = "dev"
tags = {
  Organization = "AITP"
  Purpose      = "LibreChat-Testing"
  Architecture = "Simplified"
  Environment  = "Development"
}

# Enable simplified architecture (no expensive components)
enableFirewall = false # Save ~$700/month - using NSGs instead
enableBastion  = false # Save ~$140/month - using Azure Portal/CLI for management

# Network configuration - simplified for testing
hubVnetAddressPrefixes     = ["10.0.0.0/24"]
gatewaySubnetAddressPrefix = "10.0.0.0/27"
# Firewall subnets still defined but won't be created due to enableFirewall = false
azureFirewallSubnetAddressPrefix           = "10.0.0.64/26"
azureFirewallSubnetManagementAddressPrefix = "10.0.0.128/26" 
bastionSubnetAddressPrefixes               = ["10.0.0.192/26"]

# Spoke network
spokeVnetAddressPrefixes            = ["10.1.0.0/22"]
infraSubnetAddressPrefix            = "10.1.0.0/27"
privateEndpointsSubnetAddressPrefix = "10.1.2.0/27"
infraSubnetName                     = "snet-infra"

# No jumpbox VM needed - empty subnet prefix disables VM deployment
jumpboxSubnetAddressPrefix = ""

# Supporting services
deployHelloWorldSample              = true  # Deploy test app to validate
clientIP                            = "0.0.0.0/0"  # Allow from any IP for testing - RESTRICT THIS IN PRODUCTION
supportingResourceGroupName         = "supporting-services"
aRecords                            = []
containerRegistryPullRoleAssignment = "acrRoleAssignment"
keyVaultPullRoleAssignment          = "keyVaultRoleAssignment"
appInsightsName                     = "appInsightsAca"
helloWorldContainerAppName          = "ca-hello-world"

# Container Apps configuration
workloadProfiles = [{
  name                  = "general-purpose"
  workload_profile_type = "D4"
  minimum_count         = 1
  maximum_count         = 3
}]

# Route traffic internally (no firewall)
routeSpokeTrafficInternally = true
