# 🛡️ production-infra-github-action-pipeline

Developed with ❤️ by **Mahendra Kumar**

A professional-grade Infrastructure as Code (IaC) repository showcasing a **hardened, production-ready CI/CD lifecycle** for Azure Resource Group Governance using Terraform and GitHub Actions.

[![Terraform CI/CD](https://github.com/mah1712/production-infra-github-action-pipeline/actions/workflows/deploy.yml/badge.svg)](https://github.com/mah1712/production-infra-github-action-pipeline/actions/workflows/deploy.yml)

---

## 🏗️ Project Overview
This project demonstrates an automated delivery engine for Azure infrastructure, ensuring every change is **Secure, Compliant, and Cost-Effective**. It leverages industry-standard tools to validate infrastructure before it ever touches your cloud environment.

### 📂 Directory Layout
```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml      # Professional GitHub Actions Pipeline
├── terraform/
│   ├── modules/            # Reusable Dynamic Child Modules
│   │   └── resource_group/ # Dynamic RG creation with logic
│   └── env/
│       └── dev/            # Development Configuration (Root Module)
├── .gitignore              # Hardened Git exclusion list
└── README.md               # Documentation
```

---

## 🛡️ The Pipeline Workflow (Step-by-Step)

`Init` ➔ `Fmt` ➔ `Validate` ➔ `Security Scan (TFSec/Checkov)` ➔ `Plan` ➔ `Compliance Audit (Terrascan)` ➔ `Cost Estimate (Infracost)` ➔ `Manual Approval` ➔ `Apply`

Our pipeline doesn't just deploy; it governs. Every push undergoes a rigorous 9-stage validation:

1.  **Checkout & Setup:** Initializes environment and Terraform.
2.  **Lint & Format (`fmt`):** Ensures code follows HCL best practices.
3.  **Static Analysis (`validate`):** Confirms syntax and logic are sound.
4.  **Security Scan (`TFSec`):** Scans for common cloud security misconfigurations.
5.  **Policy Compliance (`Checkov`):** Deep scan against security best practices.
6.  **Infrastructure Plan (`plan`):** Generates a precise execution plan.
7.  **Compliance Audit (`Terrascan`):** Validates against Azure security policies.
8.  **Cost Estimation (`Infracost`):** Predicts monthly spend changes in the PR.
9.  **Manual Gate & Apply:** Requires human approval before final deployment.

---

## 🛠️ Prerequisites (Mandatory Setup)

Before running the pipeline, ensure the following are configured:

### 1. Azure Backend State (OIDC Authenticated)
You must manually create the following resources to store the Terraform `.tfstate` file:
- **Resource Group**: e.g., `rg-terraform-mgmt`
- **Storage Account**: e.g., `stterraformstate001`
- **Container**: `tfstate`
- Update the `env:` variables in `.github/workflows/deploy.yml` with your specific names.

### 2. OIDC Workload Identity Setup (Passwordless Auth)
Instead of using long-lived `AZURE_CLIENT_SECRET`, this pipeline uses **OIDC (OpenID Connect)** for secure, passwordless authentication.

#### **A. Azure Portal Configuration**
1.  **Identity Management**: Create or identify an **Azure Service Principal**.
2.  **Access Control (IAM)**: 
    *   **Subscription Level**: Assign the `Contributor` or `Owner` role.
    *   **Storage Account Level**: Assign the **`Storage Blob Data Contributor`** role (Required for Terraform state management).
3.  **Establish Trust (Federated Credentials)**:
    *   Navigate to your **App Registration** > **Certificates & secrets** > **Federated credentials**.
    *   Click **Add credential** and select **GitHub Actions**.
    *   **Organization**: Your GitHub Username (e.g., `mah1712`).
    *   **Repository**: `production-infra-github-action-pipeline`.
    *   **Entity Type**: Select `Environment` (name it `production`) or `Branch` (name it `main`).
    *   This configuration allows GitHub to request a temporary, short-lived token from Azure.

### 3. GitHub Secrets Configuration
Go to **Settings -> Secrets and variables -> Actions** and add:
- `AZURE_CLIENT_ID`: Your Service Principal Client ID.
- `AZURE_TENANT_ID`: Your Azure Tenant ID.
- `AZURE_SUBSCRIPTION_ID`: Your Azure Subscription ID.
- `INFRACOST_API_KEY`: Get your free key at [Infracost.io](https://www.infracost.io/).

### 3. Environment Protection
- Create a GitHub Environment named **`production`**.
- Enable **Required Reviewers** to activate the manual approval gate.

---

## 🚀 How to Use this Repository

1.  **Fork** this repository to your GitHub account.
2.  Set up the **Secrets** as mentioned in the Prerequisites.
3.  Update the **backend variables** in `.github/workflows/deploy.yml`.
4.  **Run Pipeline!** (Triggered via push to `main` or manually via **Actions -> Run workflow**).

---

## 👨‍💻 Author
**Mahendra Kumar**  
*Cloud Infrastructure | DevSecOps | SRE Enthusiast*  
