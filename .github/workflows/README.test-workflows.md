# Test Workflows Execution Sequence

This document outlines the proper execution sequence for `test.*` workflows in the hello-azure repository.

## Overview

The workflows are organized into three environment layers that represent the infrastructure stack:

- **00-init** (Governance Layer): Foundation - Identity, access, and state management
- **10-pm** (Platform Management Layer): Core infrastructure - AKS, networking, storage
- **20-wl** (Workload Layer): Applications and services - Container images, ArgoCD, Helm deployments

## Execution Sequence

### Phase 1: Foundation (Environment: 00-init)

**1. `test.governance.tf.yaml`** - **MUST RUN FIRST** ⚠️
- **Purpose**: Initializes the tenant with foundational resources
- **Creates**:
  - Storage account for Terraform state (`tfstate`)
  - Azure AD Application Registration
  - Federated identity credentials for GitHub Actions OIDC
  - Service principal and role assignments
- **Dependencies**: None (manual Azure subscription access required)
- **Environment**: `00-init`
- **Status**: ✅ Active (workflow_dispatch + push/pull_request triggers)

> **⚠️ Critical**: This workflow must be run manually first (or via push to `preview` branch) to establish the authentication and state storage infrastructure that all subsequent workflows depend on.

---

### Phase 2: Core Infrastructure (Environment: 10-pm)

**2. `test.infrastructure.tf.apply.yaml`** - **RUNS AFTER GOVERNANCE**
- **Purpose**: Deploys core Azure infrastructure resources
- **Creates**:
  - Resource groups (core, sensitive, vnet)
  - Azure Key Vaults (main and sensitive)
  - Virtual Network and subnets
  - AKS cluster (`aks-test`)
  - Azure Container Registry (`uqhacrtest`)
  - Redis cache (`uqharedis-test`)
  - Storage accounts
  - Log Analytics workspace
  - Managed identities for various services
  - DNS zones and records
- **Dependencies**: 
  - ✅ `test.governance.tf.yaml` (for Terraform state storage and authentication)
- **Environment**: `10-pm`
- **Status**: ✅ Active (workflow_dispatch only)
- **Note**: `test.infrastructure.tf.plan.yaml` and `test.infrastructure.tf.destroy.yaml` are currently commented out

---

### Phase 3: Workloads (Environment: 20-wl)

The following workflows can run in parallel after Phase 2, but have specific ordering requirements:

**3. `test.gh.infra.yaml`** - **OPTIONAL, CAN RUN IN PARALLEL**
- **Purpose**: Provisions GitHub Actions self-hosted runners infrastructure
- **Dependencies**: 
  - ✅ `test.governance.tf.yaml` (for authentication)
  - ✅ `test.infrastructure.tf.apply.yaml` (for networking/VNet integration)
- **Environment**: `20-wl`
- **Status**: ✅ Active (workflow_dispatch only)

**4. `test.mirror-public-artifacts.yaml`** - **RUNS AFTER ACR EXISTS**
- **Purpose**: Mirrors public container images (Docker Hub, GHCR, Quay.io) to Azure Container Registry
- **Dependencies**: 
  - ✅ `test.governance.tf.yaml` (for Azure authentication)
  - ✅ `test.infrastructure.tf.apply.yaml` (ACR `uqhacrtest` must exist)
- **Environment**: `20-wl`
- **Status**: ✅ Active (workflow_dispatch only)
- **Note**: Currently commented out (needs ACR login and qcli setup)

**5. `test.mirror-unique-artifacts.yaml`** - **RUNS AFTER ACR EXISTS**
- **Purpose**: Mirrors Unique-specific container images to Azure Container Registry
- **Dependencies**: 
  - ✅ `test.governance.tf.yaml` (for Azure authentication)
  - ✅ `test.infrastructure.tf.apply.yaml` (ACR `uqhacrtest` must exist)
- **Environment**: `20-wl`
- **Status**: ✅ Active (workflow_dispatch only)
- **Note**: Requires `UNIQUECR_PASSWORD` secret

**6. `test.argocd-bootstrap.yaml`** - **RUNS AFTER AKS AND IMAGES ARE READY**
- **Purpose**: Bootstraps ArgoCD in the AKS cluster
- **Dependencies**: 
  - ✅ `test.governance.tf.yaml` (for Azure authentication)
  - ✅ `test.infrastructure.tf.apply.yaml` (AKS cluster `aks-test` must exist)
  - ✅ `test.mirror-public-artifacts.yaml` (ArgoCD container images should be available)
  - ✅ `test.mirror-unique-artifacts.yaml` (if ArgoCD uses custom images)
- **Environment**: `20-wl`
- **Status**: ✅ Active (workflow_dispatch only)
- **Calls**: `test.helm.yaml` reusable workflow with `applications/argo-bootstrap.yaml`

**7. `test.cluster.helm.yaml`** - **RUNS AFTER ARGOCD BOOTSTRAP**
- **Purpose**: Deploys cluster-level Helm charts (if any)
- **Dependencies**: 
  - ✅ `test.governance.tf.yaml` (for Azure authentication)
  - ✅ `test.infrastructure.tf.apply.yaml` (AKS cluster must exist)
  - ✅ `test.argocd-bootstrap.yaml` (ArgoCD should be running)
- **Environment**: `20-wl`
- **Status**: ✅ Active (workflow_dispatch only)
- **Calls**: `test.helm.yaml` reusable workflow

---

## Reusable Workflows

**`test.helm.yaml`** - **NOT DIRECTLY EXECUTABLE**
- **Purpose**: Reusable workflow for Helm operations (template, diff, sync/apply)
- **Status**: Reusable only (workflow_call) - called by `test.argocd-bootstrap.yaml` and `test.cluster.helm.yaml`
- **Note**: Not visible in GitHub Actions UI as it's only callable by other workflows

---

## Quick Reference: Execution Order

```
1. test.governance.tf.yaml                    [00-init] ⚠️ MUST RUN FIRST
   ↓
2. test.infrastructure.tf.apply.yaml          [10-pm]
   ↓
3. test.mirror-public-artifacts.yaml          [20-wl] ┐
   test.mirror-unique-artifacts.yaml           [20-wl] ├─ Can run in parallel
   test.gh.infra.yaml                          [20-wl] ┘
   ↓
4. test.argocd-bootstrap.yaml                  [20-wl]
   ↓
5. test.cluster.helm.yaml                      [20-wl]
```

---

## Environment Summary

| Environment | Purpose | Workflows |
|------------|---------|-----------|
| `00-init` | Foundation - Identity & State | `test.governance.tf.yaml` |
| `10-pm` | Platform - Core Infrastructure | `test.infrastructure.tf.apply.yaml` |
| `20-wl` | Workloads - Applications | `test.gh.infra.yaml`, `test.mirror-*.yaml`, `test.argocd-bootstrap.yaml`, `test.cluster.helm.yaml` |

---

## Notes

- All workflows currently use `workflow_dispatch` (manual trigger) except `test.governance.tf.yaml` which also has push/pull_request triggers
- The environment names (`00-init`, `10-pm`, `20-wl`) indicate the execution order
- Workflows in the same phase/environment can typically run in parallel if they don't depend on each other
- Always verify the previous phase completed successfully before proceeding to the next phase

