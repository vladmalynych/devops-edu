# Tilt Demo

This repository contains three demo applications configured to run with Tilt. Each demo application resides in its own directory under the `tilt` directory.

---

## Table of Contents

1. [Overview](#overview)
2. [Demo Applications](#demo-applications)
   - [hello_app](#1-hello_app)
   - [phpmyadmin_helm](#2-phpmyadmin_helm)
   - [python_debug](#3-python_debug)
3. [Getting Started](#getting-started)
4. [Additional Notes](#additional-notes)

---

## Overview

Tilt is a tool for simplifying the development and deployment of applications in Kubernetes. This repository showcases three example applications that demonstrate different capabilities of Tilt. 

Each demo application resides in its respective directory:

- `hello_app`: A basic Node.js app.
- `phpmyadmin_helm`: Deploys MySQL and phpMyAdmin using Helm charts.
- `python_debug`: A Python application with debugging capabilities.

---

## Demo Applications

### 1. `hello_app`

This application demonstrates a basic Node.js app setup with live update functionality using Tilt.

- **Namespace:** `hello-app`
- **Docker Image:** `hello-app`
- **Port Forward:** `3000 -> 3000`
- **Kubernetes Resources:** Deployment and Service
- **Special Features:**
  - Live updates for files in the `./app` directory
  - Manual trigger for listing pods using `kubectl`

---

### 2. `phpmyadmin_helm`

This setup deploys a MySQL database and phpMyAdmin using Helm charts.

- **Namespaces:** `mysql`, `phpmyadmin`
- **Helm Charts:**
  - MySQL (Bitnami)
  - phpMyAdmin (Bitnami)
- **Port Forward:** `8080 -> 8080` (phpMyAdmin)
- **Custom Values:**
  - `./helm/mysql-values.yaml`
  - `./helm/phpmyadmin-values.yaml`

---

### 3. `python_debug`

This application demonstrates how to debug a Python application in Kubernetes using Tilt.

- **Namespace:** `demo-python-pdb`
- **Docker Image:** `demo-python-pdb-img`
- **Port Forwards:**
  - `8000 -> 8000` (Web)
  - `5555 -> 5555` (Debug)
- **Kubernetes Resources:** Deployment and Service
- **Special Features:**
  - Live updates for files in the `./app` directory
  - Automatic package installation when `requirements.txt` changes

---

## Getting Started

1. **Install Tilt:**
   Ensure Tilt is installed on your system. Refer to the [Tilt installation guide](https://docs.tilt.dev/install.html).

2. **Run a Demo Application:**
   Navigate to the respective application directory and start Tilt:
   ```bash
   cd tilt/hello_app # or phpmyadmin_helm, python_debug
   tilt up
   ```

3. **Access Logs:**
   View logs and progress in the Tilt UI.

4. **Port Forwards:**
   Use the specified port forwards in each application to access the services locally.

---

## Additional Notes

- Make sure you have Kubernetes running locally (e.g., Docker Desktop or Minikube).
- Follow the output in the Tilt UI for any runtime instructions.

### Links
- Tilt: https://docs.tilt.dev/
- Tilt extensions: https://github.com/tilt-dev/tilt-extensions