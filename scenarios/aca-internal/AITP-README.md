# AITP LibreChat Azure Container Apps Deployment

## Overview
This repository contains AITP's customized Azure Container Apps Landing Zone Accelerator configuration, specifically optimized for LibreChat deployment.

## Key Modifications
- **Cost Optimization**: Removed expensive components saving ~$1,070/month
- **LibreChat Focus**: Optimized for container-based chat applications
- **Security Maintained**: Private networking, managed identities, Key Vault integration
- **Enterprise Ready**: Hub-spoke topology for scalable architecture

## Removed Components
- Azure Firewall (~$700/month savings)
- Application Gateway (~$200/month savings)
- Azure Bastion (~$140/month savings)
- Jump Box VM (~$30-60/month savings)

## Core Components Retained
- Azure Container Apps Environment (Internal)
- Hub-Spoke Virtual Network
- Azure Container Registry (Private)
- Azure Key Vault (Private)
- Log Analytics & Application Insights
- Hello World sample application

## Deployment
See [`terraform/README.md`](./terraform/README.md) for detailed deployment instructions.

## Cost Estimate
- **Optimized Configuration**: ~$50-100/month
- **Original Full Configuration**: ~$1,200/month
- **Monthly Savings**: ~$1,070

---
*Customized by AITP for LibreChat deployment requirements*
*Based on Microsoft's Azure Container Apps Landing Zone Accelerator*
