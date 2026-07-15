# Helm Charts Repository

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/unknowniq)](https://artifacthub.io/packages/search?repo=unknowniq)

This repository contains production-ready Helm charts for Kubernetes.

## Available Charts

### etcd

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/unknowniq)](https://artifacthub.io/packages/helm/unknowniq/etcd)

Production-ready etcd cluster with S3 backup, defragmentation, TLS, and OpenShift support.

- **Chart Version**: 0.1.9
- **App Version**: v3.6.11
- **Documentation**: [etcd/README.md](./etcd/README.md)

### Homepage

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/unknowniq)](https://artifacthub.io/packages/helm/unknowniq/homepage)

A modern, fully static, fast, secure fully proxied, highly customizable application dashboard with integrations for over 100 services.

- **Chart Version**: 1.8.4
- **App Version**: v1.13.1
- **Documentation**: [homepage/README.md](./homepage/README.md)

### SearXNG

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/unknowniq)](https://artifacthub.io/packages/helm/unknowniq/searxng)

Privacy-respecting metasearch engine that aggregates results from various search services without tracking users.

- **Chart Version**: 0.1.11
- **App Version**: 2026.5.17
- **Documentation**: [searxng/README.md](./searxng/README.md)

## Usage

### Adding the Helm Repository

```bash
helm repo add unknowniq https://unknowniq.github.io/helm-charts
helm repo update
```

### Installing Charts

```bash
# Install etcd
helm install my-etcd unknowniq/etcd \
  --set backup.s3.bucket=my-bucket \
  --set backup.s3.accessKey=AKIAXXXX \
  --set backup.s3.secretKey=secret

# Install homepage
helm install my-homepage unknowniq/homepage

# Install searxng
helm install my-searxng unknowniq/searxng

# Install with custom values
helm install my-release unknowniq/<chart> -f my-values.yaml
```

### Installing from Source

```bash
git clone https://github.com/UnknownIQ/helm-charts.git
cd helm-charts
helm install my-etcd ./etcd
```

## Chart Development

### Testing Charts Locally

```bash
# Lint
helm lint ./etcd

# Dry-run
helm install --dry-run --debug my-etcd ./etcd

# Template rendering
helm template my-etcd ./etcd
```

## License

See individual chart directories for license information.
