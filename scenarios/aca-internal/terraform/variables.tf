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

variable "hubResourceGroupName" {
  default = ""
}

variable "spokeResourceGroupName" {
  default = ""
}

variable "tags" {
  default = {
    Organization = "AITP"
    Purpose      = "LibreChat-Deployment"
    Architecture = "Simplified"
  }
  description = "Resource tags"
}

variable "hubVnetAddressPrefixes" {
  default = ["10.0.0.0/24"]
  description = "Address prefixes for the hub virtual network"
}

variable "enableBastion" {
  default = false
  type    = bool
  description = "Enable Azure Bastion deployment. Set to false to reduce costs (~$140/month savings)"
}

variable "enableFirewall" {
  default     = false
  type        = bool
  description = "Enable Azure Firewall deployment. Set to false to reduce costs (~$700/month savings)"
}

variable "bastionSubnetAddressPrefixes" {
  default = ["10.0.0.128/26"]
  description = "Address prefixes for bastion subnet (only used if enableBastion = true)"
}

# VM variables (not used in simplified deployment but kept for module compatibility)
variable "vmSize" {
  default = "Standard_B2ms"
  description = "VM size (not used - no VMs deployed in simplified architecture)"
}

variable "vmAdminUsername" {
  default = "vmadmin"
  description = "VM admin username (not used - no VMs deployed)"
}

variable "vmAdminPassword" {
  sensitive = true
  default   = "TempPassword123!"
  description = "VM admin password (not used - no VMs deployed)"
}

variable "vmLinuxSshAuthorizedKeys" {
  default = []
  description = "SSH keys for Linux VMs (not used - no VMs deployed)"
}

variable "vmLinuxAuthenticationType" {
  type    = string
  default = "password"
  description = "VM authentication type (not used - no VMs deployed)"
  validation {
    condition = anytrue([
      var.vmLinuxAuthenticationType == "password",
      var.vmLinuxAuthenticationType == "sshPublicKey"
    ])
    error_message = "Authentication type must be password or sshPublicKey."
  }
}

variable "vmJumpboxOSType" {
  default = "Linux"
  description = "VM OS type (not used - no VMs deployed)"
  validation {
    condition = anytrue([
      var.vmJumpboxOSType == "Linux",
      var.vmJumpboxOSType == "Windows"
    ])
    error_message = "OS Type must be Linux or Windows."
  }
}

variable "vmSubnetName" {
  default = "snet-jumpbox"
  type    = string
  description = "VM subnet name (not used - no VMs deployed)"
}

variable "ddosProtectionPlanId" {
  default = null
  type    = string
}

variable "containerAppsSecurityRules" {
  default = [
    {
      "name" : "Allow_Internal_AKS_Connection_Between_Nodes_And_Control_Plane_UDP",
      "description" : "internal AKS secure connection between underlying nodes and control plane..",
      "protocol" : "Udp",
      "sourceAddressPrefix" : "VirtualNetwork",
      "sourcePortRange" : "*",
      "destinationAddressPrefix" : "AzureCloud.eastus2",
      "destinationPortRanges" : ["1194"],
      "access" : "Allow",
      "priority" : 100,
      "direction" : "Outbound"
    },
    {
      "name" : "Allow_Internal_AKS_Connection_Between_Nodes_And_Control_Plane_TCP",
      "description" : "internal AKS secure connection between underlying nodes and control plane..",
      "protocol" : "Tcp",
      "sourceAddressPrefix" : "VirtualNetwork",
      "sourcePortRange" : "*",
      "destinationAddressPrefix" : "AzureCloud.eastus2",
      "destinationPortRanges" : ["9000"],
      "access" : "Allow",
      "priority" : 110,
      "direction" : "Outbound"
    },
    {
      "name" : "Allow_Azure_Monitor",
      "description" : "Allows outbound calls to Azure Monitor.",
      "protocol" : "Tcp",
      "sourceAddressPrefix" : "VirtualNetwork",
      "sourcePortRange" : "*",
      "destinationAddressPrefix" : "AzureCloud.eastus2",
      "destinationPortRanges" : ["443"],
      "access" : "Allow",
      "priority" : 120,
      "direction" : "Outbound"
    },
    {
      "name" : "Allow_Outbound_443",
      "description" : "Allowing all outbound on port 443 provides a way to allow all FQDN based outbound dependencies that don't have a static IP",
      "protocol" : "Tcp",
      "sourceAddressPrefix" : "VirtualNetwork",
      "sourcePortRange" : "*",
      "destinationAddressPrefix" : "*",
      "destinationPortRanges" : ["443"],
      "access" : "Allow",
      "priority" : 130,
      "direction" : "Outbound"
    },
    {
      "name" : "Allow_NTP_Server",
      "description" : "NTP server",
      "protocol" : "Udp",
      "sourceAddressPrefix" : "VirtualNetwork",
      "sourcePortRange" : "*",
      "destinationAddressPrefix" : "*",
      "destinationPortRanges" : ["123"],
      "access" : "Allow",
      "priority" : 140,
      "direction" : "Outbound"
    },
    {
      "name" : "Allow_Container_Apps_control_plane",
      "description" : "Container Apps control plane",
      "protocol" : "Tcp",
      "sourceAddressPrefix" : "VirtualNetwork",
      "sourcePortRange" : "*",
      "destinationAddressPrefix" : "*",
      "destinationPortRanges" : ["5671", "5672"],
      "access" : "Allow",
      "priority" : 150,
      "direction" : "Outbound"
    }
  ]
}

variable "vmJumpBoxSubnetAddressPrefix" {
  default = ""
  description = "Jumpbox subnet address prefix (empty = no jumpbox deployed)"
}

variable "spokeVnetAddressPrefixes" {
  default = ["10.1.0.0/22"]
  description = "Address prefixes for the spoke virtual network"
}

variable "infraSubnetAddressPrefix" {
  default = "10.1.0.0/27"
  description = "Address prefix for the infrastructure subnet (Container Apps)"
}

variable "infraSubnetName" {
  default = "snet-infra"
}

variable "privateEndpointsSubnetName" {
  default = "snet-pep"
}

variable "privateEndpointsSubnetAddressPrefix" {
  default = "10.1.2.0/27"
  description = "Address prefix for the private endpoints subnet"
}

variable "applicationGatewaySubnetName" {
  default = "snet-agw"
  description = "Application Gateway subnet name (not used in simplified deployment)"
}

variable "applicationGatewaySubnetAddressPrefix" {
  default = ""
  description = "Application Gateway subnet address prefix (empty = not deployed)"
}

variable "gatewaySubnetName" {
  default = "GatewaySubnet"
  type    = string
}

variable "gatewaySubnetAddressPrefix" {
  default = "10.0.0.0/27"
  description = "Address prefix for the gateway subnet in hub"
}

variable "azureFirewallSubnetName" {
  default = "AzureFirewallSubnet"
  type    = string
  description = "Azure Firewall subnet name (only used if enableFirewall = true)"
}

variable "azureFirewallSubnetManagementAddressPrefix" {
  default = "10.0.0.192/26"
  description = "Azure Firewall management subnet address prefix (only used if enableFirewall = true)"
}

variable "azureFirewallSubnetAddressPrefix" {
  default = "10.0.0.64/26"
  description = "Azure Firewall subnet address prefix (only used if enableFirewall = true)"
}

variable "supportingResourceGroupName" {
  default = "supporting-services"
  description = "Name of the resource group for supporting services (ACR, Key Vault)"
}

variable "aRecords" {
  default = []
  description = "A records for private DNS zones"
}

variable "containerRegistryPullRoleAssignment" {
  default = "acrRoleAssignment"
  description = "Name for the container registry pull role assignment"
}

variable "keyVaultPullRoleAssignment" {
  default = "keyVaultRoleAssignment"  
  description = "Name for the key vault role assignment"
}

variable "appInsightsName" {
  default = "appInsightsAca"
  description = "Name for Application Insights instance"
}

variable "helloWorldContainerAppName" {
  default = "ca-hello-world"
  description = "Name for the hello world container app"
}

variable "enableTelemetry" {
  type    = bool
  default = true
}

variable "deployHelloWorldSample" {
  default = true
  type    = bool
}

variable "clientIP" {
  default = "0.0.0.0/0"
  description = "Your computer's IP address for Key Vault access (use 0.0.0.0/0 for testing)"
}

variable "workloadProfiles" {
  description = "Optional, the workload profiles required by the end user. The default is 'Consumption', and is automatically added whether workload profiles are specified or not."
  type = list(object({
    name                  = string
    workload_profile_type = string
    minimum_count         = number
    maximum_count         = number
  }))
  default = [{
    name                  = "general-purpose"
    workload_profile_type = "D4"
    minimum_count         = 1
    maximum_count         = 3
  }]
}

variable "routeSpokeTrafficInternally" {
  type        = bool
  default     = false
  description = "Optional, default value is false. If true, the spoke network will route spoke-internal traffic within the spoke network. If false, traffic will be sent to the hub network."
}