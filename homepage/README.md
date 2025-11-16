# Homepage Helm Chart

A modern, fully static, fast, secure fully proxied, highly customizable application dashboard with integrations for over 100 services and translations into multiple languages.

## Introduction

This chart bootstraps a [Homepage](https://github.com/gethomepage/homepage) deployment on a Kubernetes cluster using the Helm package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- Metrics Server (for Kubernetes widgets)

## Installing the Chart

To install the chart with the release name `my-homepage`:

```bash
helm install my-homepage ./chart
```

The command deploys Homepage on the Kubernetes cluster with default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-homepage` deployment:

```bash
helm uninstall my-homepage
```

## Parameters

### Common Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of replicas | `1` |
| `image.repository` | Image repository | `ghcr.io/gethomepage/homepage` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `image.tag` | Image tag (defaults to chart appVersion) | `""` |
| `nameOverride` | Override chart name | `""` |
| `fullnameOverride` | Override full chart name | `""` |

### Service Account Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `serviceAccount.create` | Create service account | `true` |
| `serviceAccount.annotations` | Service account annotations | `{}` |
| `serviceAccount.name` | Service account name | `""` |

### RBAC Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `enableRbac` | Enable RBAC for Kubernetes integration | `true` |

### Service Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Service type | `ClusterIP` |
| `service.port` | Service port | `3000` |
| `service.annotations` | Service annotations | `{}` |

### Ingress Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `ingress.main.enabled` | Enable ingress | `false` |
| `ingress.main.className` | Ingress class name | `""` |
| `ingress.main.annotations` | Ingress annotations | `{}` |
| `ingress.main.hosts` | Ingress hosts configuration | See values.yaml |
| `ingress.main.tls` | Ingress TLS configuration | `[]` |

### Homepage Configuration Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.bookmarks` | Bookmarks configuration | `[]` |
| `config.services` | Services configuration | `[]` |
| `config.widgets` | Widgets configuration | `[]` |
| `config.kubernetes` | Kubernetes configuration | `{mode: default}` |
| `config.docker` | Docker configuration | `{}` |
| `config.settings` | Settings configuration | `{}` |
| `customCss` | Custom CSS | `""` |
| `customJs` | Custom JavaScript | `""` |

### Environment Variables

| Parameter | Description | Default |
|-----------|-------------|---------|
| `env` | Environment variables array | `[]` |

### Persistence Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.config.enabled` | Enable config persistence | `false` |
| `persistence.config.accessMode` | PVC access mode | `ReadWriteOnce` |
| `persistence.config.size` | PVC size | `1Gi` |
| `persistence.config.storageClass` | PVC storage class | `""` |
| `persistence.config.existingClaim` | Existing PVC name | `""` |

### Resource Management

| Parameter | Description | Default |
|-----------|-------------|---------|
| `resources` | Resource requests/limits | `{}` |
| `autoscaling.enabled` | Enable autoscaling | `false` |
| `autoscaling.minReplicas` | Minimum replicas | `1` |
| `autoscaling.maxReplicas` | Maximum replicas | `10` |

## Configuration Examples

### Basic Configuration with Services

```yaml
config:
  services:
    - My Services:
        - Nextcloud:
            href: https://nextcloud.example.com
            description: Personal cloud storage
            icon: nextcloud.png
        - Gitea:
            href: https://git.example.com
            description: Git hosting
            icon: gitea.png

  widgets:
    - search:
        provider: google
        target: _blank
```

### Enable Kubernetes Integration

```yaml
enableRbac: true

config:
  kubernetes:
    mode: cluster

  widgets:
    - kubernetes:
        cluster:
          show: true
          cpu: true
          memory: true
        nodes:
          show: true
          cpu: true
          memory: true
```

### Enable Ingress

```yaml
ingress:
  main:
    enabled: true
    className: nginx
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt-prod
    hosts:
      - host: homepage.example.com
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: homepage-tls
        hosts:
          - homepage.example.com

env:
  - name: HOMEPAGE_ALLOWED_HOSTS
    value: "homepage.example.com"
```

### Docker Socket Integration

```yaml
volumeMounts:
  - name: docker-sock
    mountPath: /var/run/docker.sock
    readOnly: true

volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
      type: Socket

config:
  docker: {}
```

## Security Considerations

Homepage does not include built-in authentication. For production deployments:

1. Deploy behind a reverse proxy with authentication (e.g., oauth2-proxy)
2. Use Ingress annotations for authentication
3. Deploy in a private network or behind VPN
4. Limit network access with NetworkPolicies

## Kubernetes Service Discovery

Homepage can automatically discover services in your Kubernetes cluster. To enable this feature:

1. Ensure `enableRbac: true` (default)
2. Set `config.kubernetes.mode: cluster`
3. Add annotations to your Ingresses:

```yaml
annotations:
  gethomepage.dev/enabled: "true"
  gethomepage.dev/name: "My Service"
  gethomepage.dev/description: "Service description"
  gethomepage.dev/group: "My Group"
  gethomepage.dev/icon: "service-icon.png"
```

## Additional Resources

- [Homepage Documentation](https://gethomepage.dev/)
- [GitHub Repository](https://github.com/gethomepage/homepage)
- [Widget Configuration](https://gethomepage.dev/widgets/)
- [Service Integrations](https://gethomepage.dev/widgets/services/)

## Support

For issues and questions:
- [GitHub Issues](https://github.com/gethomepage/homepage/issues)
- [GitHub Discussions](https://github.com/gethomepage/homepage/discussions)
- [Discord](https://discord.gg/k4ruYNrudu)
