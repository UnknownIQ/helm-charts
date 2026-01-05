# Helm Charts Repository

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/unknowniq)](https://artifacthub.io/packages/search?repo=unknowniq)

This repository contains Helm charts for various applications.

## Available Charts

### etcd
Production-ready etcd cluster with S3 backup support.

- **Chart Version**: 0.1.0
- **App Version**: v3.5.17
- **Documentation**: [etcd/README.md](./etcd/README.md)

### Homepage
A modern, fully static, fast, secure fully proxied, highly customizable application dashboard with integrations for over 100 services.

- **Chart Version**: 1.8.0
- **App Version**: v0.9.13
- **Documentation**: [homepage/README.md](./homepage/README.md)

### SearXNG
Privacy-respecting metasearch engine.

- **Chart Version**: 0.1.0
- **App Version**: latest
- **Documentation**: [searxng/README.md](./searxng/README.md)

## Usage

### Adding the Helm Repository

```bash
helm repo add unknowniq https://unknowniq.github.io/helm-charts
helm repo update
```

### Installing a Chart

```bash
# Install etcd chart
helm install my-etcd unknowniq/etcd \
  --set backup.s3.bucket=my-bucket \
  --set backup.s3.accessKey=AKIAXXXX \
  --set backup.s3.secretKey=secret

# Install homepage chart
helm install my-homepage unknowniq/homepage

# Install with custom values
helm install my-homepage unknowniq/homepage -f my-values.yaml
```

### Installing from Source

```bash
# Clone the repository
git clone https://github.com/UnknownIQ/helm-charts.git
cd helm-charts

# Install a chart directly
helm install my-homepage ./homepage
```

## Chart Development

### Structure

Each chart is maintained in its own directory:

```
helm-charts/
├── homepage/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── templates/
│   └── README.md
└── another-chart/
    └── ...
```

### Testing Charts Locally

```bash
# Lint the chart
helm lint ./homepage

# Dry-run installation
helm install --dry-run --debug my-homepage ./homepage

# Template rendering
helm template my-homepage ./homepage
```

## Contributing

Contributions are welcome! Please ensure:
1. Charts follow Helm best practices
2. All charts are tested before submission
3. Version numbers are updated appropriately

## License

See individual chart directories for license information.
