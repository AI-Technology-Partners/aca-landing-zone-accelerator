# Application Gateway output commented out since we disabled it
# output "applicationGatewayPublicIp" {
#   value = module.applicationGateway.applicationGatewayPublicIp
# }

output "hubResourceGroupName" {
  value = module.hub.hubResourceGroupName
}

output "spokeResourceGroupName" {
  value = module.spoke.spokeResourceGroupName
}

output "containerAppsEnvironmentFQDN" {
  value       = module.containerAppsEnvironment.containerAppsEnvironmentDefaultDomain
  description = "The default domain for the Container Apps Environment"
}

output "helloWorldAppURL" {
  value       = var.deployHelloWorldSample ? "https://${module.helloWorldApp.helloWorldAppFQDN}" : "Hello World app not deployed"
  description = "URL of the Hello World sample application (if deployed)"
}