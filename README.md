# 🚀 production-infra-github-action-pipeline

Developed with ❤️ by **Mahendra Kumar**

[![Terraform CI/CD](https://github.com/mah1712/production-infra-github-action-pipeline/actions/workflows/deploy.yml/badge.svg)](https://github.com/mah1712/production-infra-github-action-pipeline/actions/workflows/deploy.yml)

This repository provides a **Production-Ready GitHub Actions Pipeline** for automating Azure Infrastructure using Terraform.

## 🎯 Purpose
The main goal of this project is to demonstrate a **production-ready CI/CD workflow** for Terraform on Azure, including:
- **Automated Scanning:** (TFSec, Checkov)
- **Compliance & Cost:** (Terrascan, Infracost)
- **Secure Auth:** Passwordless deployment via OIDC.
- **Environment Gates:** Manual approvals for production.

---

## 🔐 Security Configuration (OIDC Setup)

Instead of using `AZURE_CLIENT_SECRET`, we use **OIDC Workload Identity**. This is the industry standard for production.

### 1. Azure Side Setup
1.  **Create/Identify a Service Principal**.
2.  **Assign Roles**: Ensure it has `Contributor` or `Owner` role on the target Subscription.
3.  **Add Federated Credentials**:
    *   Go to your App Registration -> **Certificates & secrets** -> **Federated credentials**.
    *   Add a credential for **GitHub Actions**.
    *   **Entity Type**: `Environment` (name it `production`) or `Branch` (name it `main`).
    *   This allows GitHub to request a temporary token from Azure.

### 2. GitHub Side Setup
Go to **Settings -> Secrets and variables -> Actions** and add these as **Repository Secrets**:
*   `AZURE_CLIENT_ID`: The Application (client) ID of your Service Principal.
*   `AZURE_TENANT_ID`: Your Azure AD Tenant ID.
*   `AZURE_SUBSCRIPTION_ID`: Your Azure Subscription ID.
*   `INFRACOST_API_KEY`: For cost analysis.

---

## 🏗️ Environment & Governance

### Production Environment
1.  Go to **Settings -> Environments**.
2.  Create an environment named `production`.
3.  **Required Reviewers**: Add yourself or a lead. The pipeline will **PAUSE** and wait for approval before running `terraform apply`.
4.  **Deployment Branches**: Set to `main` only.

---

## 🚀 Pipeline Workflow

| Stage | Tools | Purpose |
| :--- | :--- | :--- |
| **1. Quality & Security** | `tfsec`, `checkov` | Static Analysis & Policy compliance. |
| **2. Plan & Compliance** | `terrascan`, `infracost` | Cost estimation & Infrastructure linting. |
| **3. Manual Gate** | GitHub Environments | Human-in-the-loop review of Plan & Cost. |
| **4. Apply** | Terraform | Final infrastructure deployment. |

---

## 🛠️ Local Setup
```bash
# Update these in .github/workflows/deploy.yml
env:
  WORKING_DIR: 'terraform/env/dev'
  BACKEND_RG: 'your-resource-group'
  BACKEND_SA: 'your-storage-account'
```

---

## 👨‍💻 Author
**Mahendra Kumar**  
*Cloud & DevOps Enthusiast*

