# Applications

## Overview

This repository contains Kubernetes applications organized into two sections:

- **System**: Responsible for core infrastructure services including CRDs, operators, Kong, and Zitadel
- **Chat**: Contains all FinanceGPT-specific services including frontend and backend components

## Deployment

All applications are deployed in a Kubernetes cluster and managed through ArgoCD.

## Installation

Installation requires just a single step - launching the `argo-bootstrap.yaml`:

```bash
helmfile apply -e dev -f applications/argo-bootstrap.yaml
```

Alternatively, in this repository, you can simply run the `[dev][bootstrap ArgoCD] 🐙` workflow.
