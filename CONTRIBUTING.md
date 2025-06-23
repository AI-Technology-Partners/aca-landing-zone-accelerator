# Contributing to AITP LibreChat Azure Container Apps Landing Zone

This repository is maintained by AITP for LibreChat deployment on Azure Container Apps. We welcome contributions that improve the Terraform configuration, documentation, or operational processes.

## 🚀 Quick Start for Contributors

### Prerequisites
- Azure subscription access
- [Terraform](https://developer.hashicorp.com/terraform/install) 1.6+
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) 2.40+
- Git and GitHub account

### Making Changes

1. **Fork the repository** and create a feature branch
   ```bash
   git clone https://github.com/YOUR-USERNAME/aca-landing-zone-accelerator.git
   git checkout -b feature/your-improvement
   ```

2. **Make your changes** following our standards:
   - All Terraform code must be formatted: `terraform fmt -recursive`
   - Test changes in a development environment first
   - Update documentation if needed
   - Follow AITP naming conventions and tagging standards

3. **Test your changes**
   ```bash
   cd scenarios/aca-internal/terraform
   terraform init
   terraform validate
   terraform plan
   ```

4. **Submit a pull request**
   - Provide clear description of the change
   - Reference any related issues
   - Include testing evidence if applicable

### Repository Structure

```
├── .github/workflows/        # Terraform CI/CD pipeline
├── scenarios/aca-internal/
│   └── terraform/           # Main deployment configuration
└── scenarios/shared/terraform/ # Shared Terraform modules
```

## 📋 Standards and Conventions

### Terraform Standards
- **Formatting**: Always run `terraform fmt -recursive`
- **Validation**: Ensure `terraform validate` passes
- **Variables**: Use descriptive names with clear descriptions
- **Modules**: Keep modules focused and reusable
- **Comments**: Document complex logic and business decisions

### Git Standards
- **Branch naming**: `feature/description`, `fix/issue-description`, `docs/update-readme`
- **Commit messages**: Use conventional commits format
- **Pull requests**: One logical change per PR with clear description

### AITP-Specific Requirements
- **Tags**: Include AITP organization tags on all resources
- **Naming**: Follow Azure CAF naming conventions
- **Security**: Maintain private networking and managed identity patterns
- **Simplicity**: Avoid adding unnecessary complexity

## 🔍 What We're Looking For

### High Priority Contributions
- **Security improvements** for LibreChat deployment
- **Cost optimizations** without compromising functionality
- **Operational simplifications** and automation
- **Documentation improvements** for AITP-specific processes
- **Bug fixes** and issue resolutions

### Areas of Focus
- **Terraform module improvements** for better reusability
- **GitHub Actions enhancements** for CI/CD pipeline
- **Monitoring and alerting** configurations
- **Backup and disaster recovery** procedures
- **Performance optimizations** for Container Apps

## 📝 Issue and Pull Request Templates

### Reporting Issues
When reporting issues, please include:
- **Environment details** (Terraform version, Azure CLI version, etc.)
- **Steps to reproduce** the issue
- **Expected vs actual behavior**
- **Error messages or logs** (sanitized of sensitive data)
- **Impact assessment** (blocking, minor, enhancement)

### Pull Request Checklist
- [ ] Code follows Terraform formatting standards
- [ ] Changes have been tested in development environment
- [ ] Documentation updated if needed
- [ ] Commit messages are clear and descriptive
- [ ] No sensitive information in code or commits
