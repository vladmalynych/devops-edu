# Kargo Demo Project

This repository contains a Tilt configuration to set up and manage a demo environment for Kargo. It automates the deployment of various Kubernetes resources including ArgoCD, Argo Rollouts, CertManager, and Kargo itself, along with the necessary configurations for demo applications.

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

### Setup

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Run Tilt**:

   Run the following command to start Tilt and apply the configurations:

   ```bash
   tilt up
   ```

3. **Access the Services**:
   - **ArgoCD**: [https://localhost:8080](https://localhost:8080)
   - **Kargo API**: [https://localhost:9090](https://localhost:9090)

---

## 📜 Features

### Kubernetes Context
- Ensures the `docker-desktop` context is used for all operations.
- Parallel updates are capped at 3 for optimized resource application.

### Helm Deployments
- **ArgoCD**:
  - Deployed in the `argocd` namespace.
  - Custom values can be set in `./argocd/values.yaml`.
- **Argo Rollouts**:
  - Deployed in the `argo-rollouts` namespace.
  - Custom values can be set in `./argo-rollouts/values.yaml`.
- **CertManager**:
  - Deployed in the `cert-manager` namespace.
  - Custom values can be set in `./cert-manager/values.yaml`.
- **Kargo**:
  - Deployed in the `kargo` namespace.
  - Custom values can be set in `./kargo/values.yaml`.

### Demo Applications
Namespaces and resources for development, staging, and production are configured:
- `kargo-demo-dev`
- `kargo-demo-stage`
- `kargo-demo-prod`

The applications are managed via ArgoCD and Kargo and are defined in the following YAML files:
- `argocd/demo-app`
- `kargo/demo-app`

---

## 📂 File Structure

- `argocd/`: Configurations for ArgoCD deployment and applications.
- `kargo/`: Kargo project configurations, including stages and warehouse settings.
- `cert-manager/`: CertManager deployment values.
- `argo-rollouts/`: Argo Rollouts deployment values.

---

## 📘 Learn More

- [Tilt Documentation](https://docs.tilt.dev/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Kargo Documentation](https://kargo.akuity.io/)
- [CertManager Documentation](https://cert-manager.io/)

---


