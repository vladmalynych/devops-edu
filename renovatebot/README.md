# RenovateBot Demo Project

This repository contains a Tilt configuration to set up and manage a demo environment for RenovateBot. It automates the updating of ArgoCD dependencies within a Kubernetes environment, ensuring that Helm charts and application configurations stay up-to-date.

---

## Table of Contents
- [🚀 Getting Started](#-getting-started)
- [📜 Features](#-features)
- [📂 File Structure](#-file-structure)
- [📘 Learn More](#-learn-more)

---

## 🚀 Getting Started

To run this project, you'll need Tilt installed and configured on your local machine. For installation instructions, visit [Tilt.dev](https://tilt.dev).

### Prerequisites
- Docker Desktop with Kubernetes enabled.
- Tilt installed on your machine.
- Local kubectl configured to use the `docker-desktop` context.
- RenovateBot helm values configured to scan and update dependencies in your repo (update token/configuration).

### Setup

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Update Renovatebot configuration**:
   
   Update RenovateBot configuration:
    - Helm values: `renovatebot/renovatebot/helm/values.yaml`
    - Configuration: `.github/renovate.json`

3. **Run Tilt**:
   
   Run the following command to start Tilt and apply the configurations:
   
   ```bash
   tilt up
   ```

---

## 📜 Features

### Automated Dependency Updates
- Monitors and updates dependencies for ArgoCD applications.
- Ensures the latest security patches and improvements are integrated.
- Works with RenovateBot configurations to control update policies.


## 📂 File Structure
- **Tiltfile**
  - Located in `.Tiltfile`
- **ArgoCD Helm Configuration**:
  - Located in `argocd/helm/values.yaml`
- **ArgoCD Applications**:
  - **MySQL Demo**: Managed via `argocd/demo-mysql/helm/values.yaml`
  - **Other Applications**: Includes *Argo-Workflows* and *Metrics-Server* configurations.
  - **PHPMyAdmin Demo**: Managed via `argocd/demo-phpadmin/helm/values.yaml`
- **RenovateBot Helm Configuration**:
  - Located in `renovatebot/helm/values.yaml`
- **RenovateBot Repo Configuration**:
  - Located in project root folder `devops-edu/.github/renovate.json`

---

## 📘 Learn More

- [Tilt Documentation](https://docs.tilt.dev/)
- [RenovateBot Documentation](https://docs.renovatebot.com/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Helm Documentation](https://helm.sh/docs/)

---
