# AITP LibreChat Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        AITP LibreChat                          │
│                Azure Container Apps Landing Zone               │
│                     (Simplified Architecture)                  │
└─────────────────────────────────────────────────────────────────┘

    ┌───────────────────────────────────────────────────────────┐
    │                     HUB VNET                              │
    │                   (10.0.0.0/24)                          │
    │                                                           │
    │  ┌─────────────────┐  ┌─────────────────┐                │
    │  │   Gateway       │  │    (Bastion      │                │
    │  │   Subnet        │  │    Disabled)     │                │
    │  │  10.0.0.0/27    │  │  10.0.0.128/26   │                │
    │  └─────────────────┘  └─────────────────┘                │
    │                                                           │
    │  ┌─────────────────┐  ┌─────────────────┐                │
    │  │ (Azure Firewall │  │ (Azure Firewall │                │
    │  │   Disabled)     │  │  Mgmt Disabled) │                │
    │  │  10.0.0.64/26   │  │  10.0.0.192/26  │                │
    │  └─────────────────┘  └─────────────────┘                │
    └───────────────────────────────────────────────────────────┘
                                │
                                │ VNet Peering
                                ▼
    ┌───────────────────────────────────────────────────────────┐
    │                    SPOKE VNET                             │
    │                   (10.1.0.0/22)                          │
    │                                                           │
    │  ┌─────────────────┐  ┌─────────────────┐                │
    │  │ Container Apps  │  │ Private         │                │
    │  │ Infrastructure  │  │ Endpoints       │                │
    │  │  10.1.0.0/27    │  │  10.1.2.0/27    │                │
    │  └─────────────────┘  └─────────────────┘                │
    │           │                      │                       │
    │           ▼                      ▼                       │
    │  ┌─────────────────┐  ┌─────────────────┐                │
    │  │   ACA ENV       │  │ Azure Key Vault │                │
    │  │ (Internal)      │  │   (Private)     │                │
    │  │                 │  │                 │                │
    │  │ ┌─────────────┐ │  │ Azure Container │                │
    │  │ │ LibreChat   │ │  │ Registry (Priv) │                │
    │  │ │ Container   │ │  │                 │                │
    │  │ │ App         │ │  │                 │                │
    │  │ └─────────────┘ │  │                 │                │
    │  │                 │  │                 │                │
    │  │ ┌─────────────┐ │  └─────────────────┘                │
    │  │ │ Hello World │ │                                     │
    │  │ │ Sample App  │ │                                     │
    │  │ └─────────────┘ │                                     │
    │  └─────────────────┘                                     │
    └───────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                      MONITORING & SECURITY                     │
│                                                                 │
│  ┌─────────────────┐  ┌─────────────────┐  ┌───────────────┐   │
│  │ Log Analytics   │  │ Application     │  │ Network       │   │
│  │ Workspace       │  │ Insights        │  │ Security      │   │
│  │                 │  │                 │  │ Groups        │   │
│  └─────────────────┘  └─────────────────┘  └───────────────┘   │
└─────────────────────────────────────────────────────────────────┘

Key Simplifications:
❌ Azure Firewall (removed) → NSGs provide adequate security
❌ Application Gateway (removed) → Container Apps ingress sufficient
❌ Azure Bastion (disabled) → Azure Portal/CLI for management
❌ Jump Box VM (disabled) → No management VM needed

✅ Enterprise security maintained with private networking
✅ Hub-spoke topology preserved for scalability
✅ Cost reduced by ~$1,070/month
```

## Components Deployed

### Hub VNet Resources
- Virtual Network with gateway subnet (for future expansion)
- Private DNS zones for internal resolution
- VNet peering to spoke

### Spoke VNet Resources
- Virtual Network with container apps and private endpoint subnets
- Azure Container Apps Environment (Internal)
- Network Security Groups for traffic control
- Log Analytics Workspace

### Application Resources
- LibreChat Container App (your main application)
- Hello World Sample App (for testing)
- Azure Container Registry (Private)
- Azure Key Vault (Private)
- Application Insights

### Security & Access
- Private endpoints for ACR and Key Vault
- Managed identities for secure service access
- NSGs for network security (instead of Azure Firewall)
- Internal-only container apps (no public endpoints)

This simplified architecture maintains enterprise security while reducing operational complexity and costs for LibreChat deployment.
