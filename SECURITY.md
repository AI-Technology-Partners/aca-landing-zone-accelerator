# Security Policy

## Reporting Security Vulnerabilities

AITP takes the security of our infrastructure and applications seriously. If you believe you have found a security vulnerability in this Azure Container Apps Landing Zone for LibreChat, please report it responsibly.

### What to Report

Security vulnerabilities include but are not limited to:
- Infrastructure misconfigurations that could expose data
- Authentication or authorization bypasses
- Injection vulnerabilities in Terraform configurations
- Exposed secrets or credentials
- Network security issues

### How to Report

**Please do not report security vulnerabilities through public GitHub issues.**

For AITP team members:
- Use internal security incident reporting channels
- Contact the security team directly
- For critical issues, use the security on-call escalation

For external reporters:
- Email: security@aitp-domain.com (replace with actual domain)
- Include detailed information about the vulnerability
- Provide steps to reproduce if applicable

### What to Expect

- Acknowledgment of your report within 2 business days
- Regular updates on our progress
- Credit for responsible disclosure (if desired)

## Security Best Practices

This repository implements several security measures:
- Private networking for all Azure Container Apps
- Network Security Groups for traffic control
- Private endpoints for Azure services
- Managed identities for service authentication
- Azure Key Vault for secrets management
- Comprehensive monitoring and logging

## Supported Versions

Only the latest version of this repository is supported for security updates.

You should receive a response within 24 hours. If for some reason you do not, please follow up via email to ensure we received your original message. Additional information can be found at [microsoft.com/msrc](https://aka.ms/opensource/security/msrc). 

Please include the requested information listed below (as much as you can provide) to help us better understand the nature and scope of the possible issue:

  * Type of issue (e.g. buffer overflow, SQL injection, cross-site scripting, etc.)
  * Full paths of source file(s) related to the manifestation of the issue
  * The location of the affected source code (tag/branch/commit or direct URL)
  * Any special configuration required to reproduce the issue
  * Step-by-step instructions to reproduce the issue
  * Proof-of-concept or exploit code (if possible)
  * Impact of the issue, including how an attacker might exploit the issue

This information will help us triage your report more quickly.

If you are reporting for a bug bounty, more complete reports can contribute to a higher bounty award. Please visit our [Microsoft Bug Bounty Program](https://aka.ms/opensource/security/bounty) page for more details about our active programs.

## Preferred Languages

We prefer all communications to be in English.

## Policy

Microsoft follows the principle of [Coordinated Vulnerability Disclosure](https://aka.ms/opensource/security/cvd).

<!-- END MICROSOFT SECURITY.MD BLOCK -->
