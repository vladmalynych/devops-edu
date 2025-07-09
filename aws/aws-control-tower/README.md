# AWS Control Tower Demo & Overview

## What is AWS Control Tower?

**AWS Control Tower** is a service that helps set up and govern a secure, multi-account AWS environment based on AWS best practices. It automates the setup of a landing zone and provides governance using **guardrails**, **account provisioning**, and **centralized logging**.

This guide provides a step-by-step walkthrough to set up AWS Control Tower via the AWS Console and compares it to manually managing AWS accounts.

---

## 🚀 Setting Up AWS Control Tower (Console-based Walkthrough)

### Prerequisites

* An AWS Organization with all features enabled
* Root account access or sufficient IAM privileges
* Region support (Control Tower is not available in all regions — start in `us-east-1` or `eu-west-1`)

### Step 1: Access Control Tower Dashboard

1. Sign in to the AWS Management Console using the root account.
2. Navigate to **Control Tower** from the Services menu or search bar.
3. Click **Set up landing zone**.

![Step 1](./images/control-tower-step1-dashboard.png)

### Step 2: Set up the Landing Zone

1. Review the overview page and click **Set up landing zone**.
2. Provide required information for:

   * **Account email addresses** (for Log Archive and Audit accounts)
   * **Organizational Unit (OU)** name
   * **SSO configuration** (optional)

![Step 2](./images/control-tower-step2-landing-zone.png)

### Step 3: Configure Regions and Guardrails

1. Select **governed regions** (e.g., us-east-1, eu-west-1).
2. Choose **mandatory** and **optional guardrails** to enforce security policies.
3. Confirm the account factory settings.

![Step 3](./images/control-tower-step3-guardrails.png)

### Step 4: Launch and Monitor Setup

1. Review all configurations.
2. Click **Set up landing zone**.
3. The setup takes \~30–60 minutes.

![Step 4](./images/control-tower-step4-review.png)

### Step 5: Provision New Accounts (Optional)

Once the landing zone is ready:

1. Go to **Account Factory** from Control Tower.
2. Click **Enroll account**.
3. Provide:

   * Account name and email
   * Organizational unit
   * IAM role name
   * VPC configuration (optional)

![Step 5](./images/control-tower-step5-account-factory.png)

---

## 🤝 Control Tower vs. Manual Account Management

### ✅ Pros of AWS Control Tower

| Benefit                          | Description                                                           |
| -------------------------------- | --------------------------------------------------------------------- |
| **Standardization**              | Enforces account structure, security baselines, and best practices.   |
| **Automated Guardrails**         | Predefined preventive/detective controls for security and compliance. |
| **Account Factory**              | Self-service account provisioning with governance baked in.           |
| **Centralized Logging**          | Aggregates CloudTrail and Config logs in a dedicated account.         |
| **Governed Multi-Account Setup** | OUs and SCPs managed from a single dashboard.                         |
| **SSO Integration**              | Easy integration with AWS IAM Identity Center (formerly SSO).         |

### ⚠️ Cons of AWS Control Tower

| Limitation                      | Description                                                              |
| ------------------------------- | ------------------------------------------------------------------------ |
| **Limited Customization**       | Complex setups (custom org SCPs, landing zones) may clash with defaults. |
| **Region Availability**         | Not available in all AWS regions.                                        |
| **Slow Initial Setup**          | Landing zone provisioning can take up to an hour.                        |
| **Tight Coupling**              | Harder to detach Control Tower later due to dependencies.                |
| **No Native Terraform Support** | Console-first experience; IaC support is indirect and complex.           |

### 🛠️ Manual Account Management: Pros & Cons

| Pros                       | Cons                                                              |
| -------------------------- | ----------------------------------------------------------------- |
| Full Flexibility           | No guardrails — more prone to misconfiguration                    |
| Complete Customization     | No built-in governance or centralized audit/logging               |
| Suited for niche use cases | Manual effort for SSO, SCPs, security baselines                   |
| Better Terraform Control   | More effort to enforce org-wide standards and compliance manually |

---

## 📜 Summary: When to Use AWS Control Tower vs Manual Management

| Use Case / Criteria                                         | Use AWS Control Tower | Use Manual Setup |
| ----------------------------------------------------------- | --------------------- | ---------------- |
| You need to quickly set up a secure multi-account structure | ✅                     | ❌                |
| You want out-of-the-box best practices & guardrails         | ✅                     | ❌                |
| You require deep customization or non-standard setups       | ❌                     | ✅                |
| You’re already using Terraform for everything               | ⚠️ (limited support)  | ✅                |
| You want centralized logging & audit out-of-the-box         | ✅                     | ❌                |
| You need support for all AWS regions                        | ❌ (limited)           | ✅                |
| You want full control over IAM, SCPs, and billing manually  | ❌                     | ✅                |

