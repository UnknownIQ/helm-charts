# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Helm charts repository that packages Kubernetes applications for easy deployment. Each chart is self-contained in its own directory at the repository root (e.g., `homepage/`, `searxng/`, `etcd/`). Charts are automatically released via GitHub Pages when merged to the `main` branch.

**Available Charts:**
- **homepage**: Application dashboard with 100+ service integrations
- **searxng**: Privacy-respecting metasearch engine
- **etcd**: Production-ready distributed key-value store with S3 backups

## Common Commands

### Linting and Testing

```bash
# Lint a specific chart
helm lint ./homepage
helm lint ./searxng

# Lint all changed charts using chart-testing tool
ct lint --config ./ci/configs/chart-testing.yaml

# Dry-run installation to see rendered templates
helm install --dry-run --debug my-homepage ./homepage

# Template rendering only (no cluster needed)
helm template my-homepage ./homepage
```

### Installing Charts Locally

```bash
# Install from local directory
helm install my-homepage ./homepage

# Install with custom values
helm install my-homepage ./homepage -f custom-values.yaml

# Upgrade existing installation
helm upgrade my-homepage ./homepage

# Uninstall
helm uninstall my-homepage
```

### Managing Dependencies

```bash
# Update chart dependencies (for charts like searxng that have dependencies)
helm dependency update ./searxng

# List dependencies
helm dependency list ./searxng
```

### Documentation

```bash
# Generate/update chart documentation from values.yaml and templates
./ci/scripts/helm-docs.sh

# This installs helm-docs v1.14.2 and validates that docs are up-to-date
# Documentation is auto-generated from values.yaml comments and Chart.yaml
```

### Testing with Kind

```bash
# Create a local Kubernetes cluster for testing
kind create cluster

# Install chart for testing
helm install test-homepage ./homepage

# Clean up
helm uninstall test-homepage
kind delete cluster
```

### Full CI Pipeline Locally

```bash
# Run complete linting
ct lint --config ./ci/configs/chart-testing.yaml

# Create Kind cluster and run installation tests
kind create cluster
ct install --config ./ci/configs/chart-testing.yaml
```

## Architecture

### Chart Structure

Each chart follows this standard Helm structure:

```
chart-name/
├── Chart.yaml              # Chart metadata (version, appVersion, dependencies)
├── values.yaml             # Default configuration with inline documentation
├── values.schema.json      # JSON schema for values validation
├── README.md               # Auto-generated documentation (via helm-docs)
├── Chart.lock              # Dependency lock file (if chart has dependencies)
├── icon.png/svg            # Chart icon
├── templates/
│   ├── _helpers.tpl        # Template helper functions
│   ├── deployment.yaml     # Main application deployment
│   ├── service.yaml        # Kubernetes Service
│   ├── configmap.yaml      # Configuration management
│   ├── serviceaccount.yaml # RBAC service account
│   ├── ingress.yaml        # Ingress controller support
│   ├── httproute.yaml      # Gateway API HTTPRoute support
│   ├── servicemonitor.yaml # Prometheus monitoring
│   ├── networkpolicy.yaml  # Network policies
│   ├── poddisruptionbudget.yaml
│   ├── pvc.yaml            # Persistent volume claims
│   └── NOTES.txt           # Post-install instructions
└── charts/                 # Subcharts (packaged dependencies)
```

### Template Helpers Pattern

All charts use `_helpers.tpl` with these standard template functions:
- `<chart>.name` - Chart name (with override support)
- `<chart>.fullname` - Fully qualified app name
- `<chart>.chart` - Chart name and version for labels
- `<chart>.labels` - Common labels including Helm chart metadata
- `<chart>.selectorLabels` - Pod selector labels
- `<chart>.serviceAccountName` - Service account name with conditional logic
- `<chart>.image` - Full image name with tag (defaults to Chart.appVersion)

### Gateway API Support

Charts support both traditional Ingress and modern Gateway API (HTTPRoute). When adding networking:
- Use `httproute.yaml` for Gateway API with conditional `{{ if .Values.httproute.enabled }}`
- Reference a Gateway via `parentRefs` with namespace/name from values
- Both can be enabled simultaneously for migration scenarios

### CI/CD Pipeline

**Pull Request Workflow (`.github/workflows/ci.yaml`):**
- Triggers on chart-related file changes (Chart.yaml, values.yaml, templates/)
- Lints charts with `ct lint`
- Creates temporary Kind cluster
- Installs and tests charts with `ct install`
- Validates documentation with helm-docs (ensures README.md is up-to-date)
- Validates YAML schemas

**Release Workflow (`.github/workflows/release.yaml`):**
- Triggers on push to `main` branch with chart changes
- Uses `chart-releaser` to package charts
- Automatically creates GitHub releases
- Updates Helm repository index on gh-pages branch
- Adds required Helm repositories (e.g., Valkey for searxng)

### Chart Dependencies

When a chart depends on another Helm chart:
1. Add dependency to `Chart.yaml` with `condition` field for optional dependencies
2. Add the parent repository to `.github/workflows/release.yaml` in the "Add Helm repositories" step
3. Run `helm dependency update ./chart-name` to create/update Chart.lock
4. Configure dependency values under the subchart name in values.yaml (e.g., `valkey:` for searxng)

Example from searxng:
```yaml
dependencies:
  - name: valkey
    version: "0.7.1"
    repository: https://valkey-io.github.io/valkey-helm/
    condition: valkey.enabled
```

### Version Management

- **Chart Version** (`version` in Chart.yaml): Increment for any chart changes
  - Patch: Bug fixes, documentation updates
  - Minor: New features, backwards-compatible changes
  - Major: Breaking changes
- **App Version** (`appVersion` in Chart.yaml): Version of the application being deployed
- Update both in Chart.yaml before merging to `main`
- Release workflow automatically creates GitHub release based on chart version

### Security Configuration

Charts implement security best practices:
- Pod security contexts with `runAsNonRoot: true` and specific user/group IDs
- Capability dropping with `drop: ["ALL"]`
- Read-only root filesystems where possible
- Service accounts with minimal RBAC permissions
- Network policies for traffic restriction
- ConfigMaps for configuration (Secrets for sensitive data)

When modifying security settings, maintain these defaults unless there's a specific requirement.

### Adding a New Chart

1. Create new directory at repository root: `new-chart/`
2. Initialize chart structure (use existing charts as templates)
3. Create `Chart.yaml` with chart and app versions
4. Create `values.yaml` with well-documented configuration options
5. Create `values.schema.json` for validation
6. Add templates following the standard structure above
7. Ensure `_helpers.tpl` follows the naming pattern: `<chart-name>.<helper>`
8. Test locally: `helm lint ./new-chart` and `helm template ./new-chart`
9. If chart has dependencies, add parent repos to release workflow
10. Generate docs: `./ci/scripts/helm-docs.sh`
11. CI will automatically test on PR and release on merge to `main`

### Helm Repository Configuration

The repository is published at: `https://<username>.github.io/helm-charts`

Users install charts with:
```bash
helm repo add my-charts https://<username>.github.io/helm-charts
helm repo update
helm install my-release my-charts/chart-name
```
