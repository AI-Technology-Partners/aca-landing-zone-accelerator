# Deploy the regional hub

This is the first step in the step-by-step deployment guide for the [Azure Container Apps - Internal environment secure baseline](../../README.md). This hub provides core networking infrastructure for the simplified LibreChat deployment.

## Networking in this architecture

The hub network provides the foundation for the hub-spoke topology used in this simplified architecture. For AITP's LibreChat deployment, the hub contains only essential networking components, with Azure Firewall and Bastion removed to reduce complexity and costs.

## Expected results

After executing these steps you'll have the hub resource group (`rg-lzaaca-hub-dev-reg`, by default) populated with a regional virtual network and Log Analytics workspace. Azure Bastion and Azure Firewall are **not deployed** in this simplified version.

### Resources

- Hub resource group  
- Hub virtual network
- Log Analytics workspace
- ~~Azure Bastion~~ (removed for cost savings)
- ~~Azure Firewall~~ (removed for cost savings - using NSGs instead)

### IP addressing

Since this walkthrough is expected to be deployed isolated from existing infrastructure and not joined to any of your existing networks; the IP addresses should not come in conflict with any existing networking you have, even if those IP addresses overlap with ones you already have in your enterprise. However, if you need to join existing networks, even for the purposes this walkthrough, you'll need to adjust the IP space before deploying. See [Review and update deployment parameters](../../README.md#steps).

#### Configure Terraform remote state

To configure your Terraform deployment to use the newly provisioned storage account and container, edit the [`./providers.tf`](./providers.tf) file at lines 11-13 as below:

```hcl
backend "azurerm" {
  resource_group_name  = "<REPLACE with $RESOURCE_GROUP_NAME>"
  storage_account_name = "<REPLACE with $STORAGE_ACCOUNT_NAME>"
  container_name       = "tfstate"
  key                  = "acalza/hub.tfstate"
}
```

* `resource_group_name`: Name of the Azure Resource Group that the storage account resides in.
* `storage_account_name`: Name of the Azure Storage Account to be used to hold remote state.
* `container_name`: Name of the Azure Storage Account Blob Container to store remote state.
* `key`: Path and filename for the remote state file to be placed in the Storage Account Container. If the state file does not exist in this path, Terraform will automatically generate one for you.

## Steps

1. Navigate to the Terraform module for the hub. 
   
   ```bash
   cd modules/01-hub
   ```

2. Set the desired region and Virtual Machine Administrator Password in the [terraform.tfvars file](./terraform.tfvars)
   :stop_sign: Update this to your desired region.

   ```Terraform
   location="eastus" # or any location that suits your needs
   vmAdminPassword = "<Strong Password>"
   ```

3. Create the regional network hub

    ```bash
    terraform init
    terraform plan -out tfplan
    terraform apply tfplan 
    ```

## Next step
:arrow_forward: [Spoke](../02-spoke/README.md)
