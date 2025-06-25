# GitHub Actions Setup for AITP LibreChat Azure Container Apps Deployment

This document explains how to configure GitHub Actions for automated Terraform deployment of the AITP LibreChat Azure Container Apps Landing Zone.

## Required GitHub Secrets

Configure the following secrets in your GitHub repository settings (`Settings > Secrets and variables > Actions`):

### Azure Authentication
```
AZURE_CREDENTIALS          # Service Principal JSON (legacy format for azure/login action)
ARM_CLIENT_ID              # Service Principal Application ID
ARM_CLIENT_SECRET          # Service Principal Secret
ARM_SUBSCRIPTION_ID        # Azure Subscription ID
ARM_TENANT_ID              # Azure AD Tenant ID
```

### Azure Service Principal Creation

Create a service principal with Contributor access to your subscription:

```bash
# Create service principal
az ad sp create-for-rbac --name "sp-aitp-librechat-github" \
  --role Contributor \
  --scopes /subscriptions/YOUR_SUBSCRIPTION_ID \
  --sdk-auth

# The output will be used for AZURE_CREDENTIALS secret
# Extract individual values for ARM_* secrets
```

## Required GitHub Variables

Configure the following variables in your GitHub repository settings (`Settings > Secrets and variables > Actions > Variables`):

### Terraform State Storage
```
TF_STATE_RESOURCE_GROUP     # Resource group containing Terraform state storage account
TF_STATE_STORAGE_ACCOUNT    # Storage account name for Terraform state
TF_STATE_CONTAINER_NAME     # Container name for state files (usually "tfstate")
TF_STATE_KEY               # State file key (e.g., "aitp-librechat/terraform.state")
```

### Deployment Configuration
```
CLIENT_IP                  # Your public IP address for Key Vault access
DESTROY_APPROVERS          # GitHub usernames who can approve destroy operations (comma-separated)
```

## Terraform State Storage Setup

Before using the GitHub Actions workflow, create the Terraform state storage:

```bash
# Set variables
LOCATION="eastus"
RESOURCE_GROUP_NAME="rg-aitp-tfstate"
STORAGE_ACCOUNT_NAME="saitptfstate$(date +%s)"  # Must be globally unique
CONTAINER_NAME="tfstate"

# Create Resource Group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create Storage Account
az storage account create \
  --name $STORAGE_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --location $LOCATION \
  --sku Standard_LRS \
  --encryption-services blob

# Create blob container
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT_NAME
```

## GitHub Environments

Create a `production` environment in your repository (`Settings > Environments`) for additional protection:

1. **Environment name**: `production`
2. **Protection rules**:
   - ✅ Required reviewers (add team members)
   - ✅ Wait timer: 5 minutes (optional)
   - ✅ Deployment branches: Selected branches > `main`

## Workflow Triggers

The workflow supports three triggers:

### 1. Automatic Plan (Pull Requests)
- **Trigger**: Pull request to `main` branch with Terraform changes
- **Action**: Runs `terraform plan` and posts results as comment
- **Approval**: None required

### 2. Automatic Deploy (Main Branch)
- **Trigger**: Push to `main` branch with Terraform changes
- **Action**: Runs `terraform apply` automatically
- **Approval**: Production environment protection rules

### 3. Manual Operations (Workflow Dispatch)
- **Trigger**: Manual workflow execution
- **Actions**: 
  - `plan` - Generate and review execution plan
  - `apply` - Deploy infrastructure changes
  - `destroy` - Remove all infrastructure (requires approval)
- **Approval**: Production environment + manual approval for destroy

## Usage Examples

### Deploy Changes
1. Create feature branch: `git checkout -b feature/update-config`
2. Make changes to Terraform files
3. Push and create PR: GitHub Actions runs `terraform plan`
4. Review plan in PR comments
5. Merge PR: GitHub Actions runs `terraform apply`

### Emergency Destroy
1. Go to `Actions` tab in GitHub
2. Select "AITP LibreChat ACA Deployment" workflow
3. Click "Run workflow"
4. Select `destroy` action
5. Approve the manual approval request
6. Infrastructure will be destroyed

## Security Considerations

- **Service Principal**: Uses least-privilege access (Contributor to subscription)
- **State Storage**: Encrypted at rest in Azure Storage
- **Secrets**: Stored securely in GitHub Secrets
- **Approvals**: Required for production deployments and destroy operations
- **Branch Protection**: Only main branch can trigger production deployments

## Troubleshooting

### Common Issues

1. **Authentication Failures**
   - Verify service principal credentials
   - Check subscription and tenant IDs
   - Ensure service principal has Contributor role

2. **State Storage Issues**
   - Verify storage account exists and is accessible
   - Check container name and state key configuration
   - Ensure service principal has Storage Blob Data Contributor role

3. **Variable Errors**
   - Verify all required GitHub variables are set
   - Check CLIENT_IP format (should be single IP address)
   - Ensure approvers list uses valid GitHub usernames

### Getting Help

- Check workflow run logs in GitHub Actions tab
- Review Terraform error messages for specific issues
- Verify Azure resource quotas and limits
- Ensure all required resource providers are registered

## Next Steps

After setting up GitHub Actions:

1. Configure all required secrets and variables
2. Test with a small change to trigger the workflow
3. Monitor the first deployment carefully
4. Set up monitoring and alerting for the deployed resources
5. Create runbooks for common operational tasks
