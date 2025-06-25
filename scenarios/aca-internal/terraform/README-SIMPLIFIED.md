# AITP's Azure Container Apps Landing Zone - LibreChat Deployment

This is **AITP's customized vPerfect for:
- **Focused container deployments** like LibreChat
- **Simplified production workloads** without complex networking needs
- **Teams prioritizing operational simplicity**
- **Organizations wanting essential enterprise features without bloat**

Consider the full deployment for:
- **Complex multi-service architectures** requiring advanced traffic management
- **Environments with strict compliance** requiring additional security layers
- **Large organizations** with dedicated network/security teams the Azure Container Apps Landing Zone Accelerator, streamlined for LibreChat deployment by removing unnecessary complexity while maintaining enterprise-grade security and functionality.

## � **Simplified Components**

### **Removed (Unnecessary Complexity):**
- **Azure Firewall** - Not needed; Network Security Groups provide adequate protection
- **Application Gateway** - Not needed; Container Apps ingress handles traffic routing  
- **Azure Bastion** - Not needed; Azure Portal/CLI provides sufficient management access
- **Jump Box VM** - Not needed; No requirement for in-network management VM

**Complexity Reduction Benefits:**
- Fewer moving parts to manage and maintain
- Simpler network routing and security model
- Reduced operational overhead
- Cost savings as secondary benefit (~$1,070/month)

## ✅ What's Still Deployed

**Core Components (Essential):**
- Azure Container Apps Environment (Internal/Private)
- Hub-Spoke Virtual Network topology
- Azure Container Registry (Private)
- Azure Key Vault (Private)
- Log Analytics Workspace
- Application Insights
- Hello World sample application
- Private DNS zones and endpoints
- Network Security Groups

**Estimated Monthly Cost: ~$50-100** (simplified architecture with essential components only)

## 🔧 Configuration Changes Made

### In `terraform.tfvars`:
```hcl
enableBastion = false              # Not needed for LibreChat deployment
enableFirewall = false             # NSGs provide adequate security
# Removed VM configuration - no management VM required
# Removed Application Gateway configuration - Container Apps ingress sufficient
```

### In `main.tf`:
```hcl
# Commented out Application Gateway module - not needed for LibreChat
# Set empty subnet prefixes to skip unnecessary components
# Simplified routing without firewall dependency
```

## 🚀 How to Deploy

1. **Update your IP address** in `terraform.tfvars`:
```hcl
clientIP = "YOUR.IP.ADDRESS.HERE"  # For Key Vault access
```

2. **Deploy with Terraform**:
```bash
terraform init
terraform plan
terraform apply
```

## 🔗 Accessing Your Applications

Since we removed the Application Gateway and Bastion:

1. **Container Apps** are accessible via their internal FQDN within the VNet
2. **Management** should be done via Azure Portal/CLI
3. **Hello World App** URL will be output after deployment

## 🔒 Security Notes

- Container Apps Environment is still **internal/private** (no public endpoints)
- Network security is maintained through **NSGs** instead of Azure Firewall
- Private endpoints ensure **ACR and Key Vault** remain private
- **Hub-spoke topology** provides network segmentation

## 📈 Scaling Up Later

If you need the removed components later, you can:

1. Set `enableBastion = true` to add Bastion
2. Set `enableFirewall = true` and add firewall variables
3. Uncomment the Application Gateway module
4. Add back VM configuration for jump box

## 🎯 Use Cases

**Perfect for AITP's LibreChat deployment:**
- **Cost-effective production workloads**
- **Secure internal chat applications**
- **Container-based AI/ML services**
- **Enterprise chat platforms**

Perfect for general use:
- **Development/Testing environments**
- **Small to medium production workloads**
- **Cost-conscious deployments**
- **Learning Container Apps**

Consider the full deployment for:
- **Large-scale enterprise production workloads**
- **High security compliance requirements**
- **Multi-workload environments with complex networking**
- **Specific compliance requirements**
