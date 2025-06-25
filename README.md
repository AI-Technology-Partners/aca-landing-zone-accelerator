# AITP Azure Container Apps Landing Zone for LibreChat

This repository contains AITP's customized Azure Container Apps Landing Zone Accelerator, specifically optimized for LibreChat deployment using Terraform. The configuration has been simplified to remove unnecessary complexity while maintaining enterprise-grade security and functionality.

## 🎯 Purpose

This landing zone accelerator provides a **production-ready, simplified infrastructure** for deploying LibreChat on Azure Container Apps with:

- **Reduced Complexity**: Removed unnecessary components (Azure Firewall, Application Gateway, Bastion, Jump Box VM)
- **Enterprise Security**: Maintained private networking, managed identities, and Key Vault integration
- **Cost Efficiency**: Simplified architecture results in ~$1,070/month cost savings
- **Operational Simplicity**: Fewer moving parts to manage and maintain

## 🏗️ Architecture

See detailed architecture: [AITP LibreChat Architecture](./scenarios/aca-internal/AITP-ARCHITECTURE.md)

**Core Components:**
- Azure Container Apps Environment (Internal/Private)
- Hub-Spoke Virtual Network topology
- Azure Container Registry (Private)
- Azure Key Vault (Private)
- Log Analytics & Application Insights
- Private DNS zones and endpoints
- Network Security Groups for security

**Removed Components:**
- ❌ Azure Firewall (~$700/month) - NSGs provide adequate security
- ❌ Application Gateway (~$200/month) - Container Apps ingress sufficient
- ❌ Azure Bastion (~$140/month) - Azure Portal/CLI for management
- ❌ Jump Box VM (~$30-60/month) - No management VM needed

## 🚀 Quick Start

### Prerequisites
- Azure subscription with Owner role
- [Terraform](https://developer.hashicorp.com/terraform/install) 1.6+
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) 2.40+
- Resource providers registered: `Microsoft.App`, `Microsoft.ContainerRegistry`, `Microsoft.KeyVault`

### Deploy with Terraform

1. **Clone this repository**
   ```bash
   git clone https://github.com/YOUR-ORG/aca-landing-zone-accelerator.git
   cd aca-landing-zone-accelerator/scenarios/aca-internal/terraform
   ```

2. **Configure variables**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your IP address
   ```

3. **Deploy infrastructure**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### Deploy with GitHub Actions

See [GitHub Actions Setup Guide](./.github/GITHUB-ACTIONS-SETUP.md) for automated CI/CD deployment.

## 📁 Repository Structure

```
├── .github/
│   ├── workflows/lza-deployment.yml    # Terraform CI/CD workflow
│   └── GITHUB-ACTIONS-SETUP.md        # GitHub Actions configuration guide
├── scenarios/
│   ├── aca-internal/
│   │   ├── terraform/                  # Main Terraform configuration
│   │   ├── AITP-README.md             # AITP customization overview
│   │   └── README.md                  # Deployment guide
│   └── shared/
│       └── terraform/                  # Shared Terraform modules
└── README.md                          # This file
```

## 📊 Cost Comparison

| Component | Original | Simplified | Monthly Savings |
|-----------|----------|------------|----------------|
| Azure Firewall | ~$700 | $0 | $700 |
| Application Gateway | ~$200 | $0 | $200 |
| Azure Bastion | ~$140 | $0 | $140 |
| Jump Box VM | ~$30-60 | $0 | $30-60 |
| **Total Infrastructure** | **~$1,200** | **~$50-100** | **~$1,070** |

## 🔒 Security & Compliance

Despite the simplification, enterprise security is maintained:

- **Private Networking**: All Container Apps are internal-only
- **Network Segmentation**: Hub-spoke topology with proper subnet isolation
- **Identity Security**: Managed identities for service-to-service authentication
- **Secrets Management**: Azure Key Vault for secure credential storage
- **Monitoring**: Complete observability with Log Analytics and Application Insights
- **Network Security**: NSGs provide adequate protection for container workloads

## 🛠️ Customization

This repository is specifically tailored for AITP's LibreChat deployment. Key customizations include:

- **Workload**: Optimized for LibreChat container application
- **Network**: Simplified security model using NSGs instead of Azure Firewall
- **Access**: Management via Azure Portal/CLI instead of dedicated jump box
- **Traffic**: Direct Container Apps ingress instead of Application Gateway
- **Tags**: AITP organization tags and "Simplified" architecture designation

## 📚 Documentation

- **[Deployment Guide](./scenarios/aca-internal/terraform/README.md)** - Detailed Terraform deployment instructions
- **[Simplification Summary](./scenarios/aca-internal/terraform/SIMPLIFICATION-SUMMARY.md)** - What was changed and why
- **[GitHub Actions Setup](./.github/GITHUB-ACTIONS-SETUP.md)** - CI/CD pipeline configuration
- **[AITP Overview](./scenarios/aca-internal/AITP-README.md)** - AITP-specific customizations

## 🤝 Contributing

This repository is maintained by AITP for LibreChat deployment. For issues or suggestions:

1. Create an issue describing the problem or enhancement
2. For changes, create a feature branch and submit a pull request
3. Ensure all Terraform code is formatted (`terraform fmt`)
4. Test changes in a development environment first

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Based on Microsoft's [Azure Container Apps Landing Zone Accelerator](https://github.com/Azure/aca-landing-zone-accelerator), customized by AITP for simplified LibreChat deployment.

---

**🎯 Ready to deploy LibreChat on Azure Container Apps with enterprise security and simplified operations.**
