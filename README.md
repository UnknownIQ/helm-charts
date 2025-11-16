# Helm Charts Repository

This repository contains Helm charts for various applications.

## Available Charts

### Homepage
A modern, fully static, fast, secure fully proxied, highly customizable application dashboard with integrations for over 100 services.

- **Chart Version**: 1.7.0
- **App Version**: 1.7.0
- **Documentation**: [homepage/README.md](./homepage/README.md)

## Usage

### Adding the Helm Repository

```bash
helm repo add my-charts https://<username>.github.io/helm-charts
helm repo update
```

### Installing a Chart

```bash
# Install homepage chart
helm install my-homepage my-charts/homepage

# Install with custom values
helm install my-homepage my-charts/homepage -f my-values.yaml
```

### Installing from Source

```bash
# Clone the repository
git clone https://github.com/<username>/helm-charts.git
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
