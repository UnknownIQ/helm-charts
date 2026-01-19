# searxng

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2026.1.9-b83e88ea7](https://img.shields.io/badge/AppVersion-2026.1.9--b83e88ea7-informational?style=flat-square)

A privacy-respecting, hackable metasearch engine that aggregates results from various search services without tracking users.

**Homepage:** <https://github.com/searxng/searxng>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| UnknownIQ |  |  |

## Source Code

* <https://github.com/searxng/searxng>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://valkey-io.github.io/valkey-helm/ | valkey | 0.7.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config.engines[0].disabled | bool | `false` |  |
| config.engines[0].name | string | `"duckduckgo"` |  |
| config.engines[1].disabled | bool | `false` |  |
| config.engines[1].name | string | `"google"` |  |
| config.engines[2].disabled | bool | `false` |  |
| config.engines[2].name | string | `"wikipedia"` |  |
| config.engines[3].disabled | bool | `false` |  |
| config.engines[3].name | string | `"github"` |  |
| config.engines[4].disabled | bool | `false` |  |
| config.engines[4].name | string | `"stackoverflow"` |  |
| config.general.enable_metrics | bool | `true` |  |
| config.general.instance_name | string | `"SearXNG"` |  |
| config.general.open_metrics | string | `""` |  |
| config.search.autocomplete | string | `""` |  |
| config.search.ban_time_on_fail | int | `5` |  |
| config.search.max_ban_time_on_fail | int | `120` |  |
| config.search.safe_search | int | `0` |  |
| config.server.base_url | bool | `false` |  |
| config.server.image_proxy | bool | `false` |  |
| config.server.limiter | bool | `false` |  |
| config.server.method | string | `"POST"` |  |
| config.server.public_instance | bool | `false` |  |
| config.server.secret_key | string | `""` |  |
| config.ui.center_alignment | bool | `false` |  |
| config.ui.default_locale | string | `""` |  |
| config.ui.default_theme | string | `"simple"` |  |
| config.ui.infinite_scroll | bool | `false` |  |
| config.ui.query_in_title | bool | `false` |  |
| deploymentAnnotations | object | `{}` |  |
| env | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"searxng/searxng"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.main.annotations | object | `{}` |  |
| ingress.main.className | string | `""` |  |
| ingress.main.enabled | bool | `false` |  |
| ingress.main.hosts[0].host | string | `"searxng.local"` |  |
| ingress.main.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.main.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.main.tls | list | `[]` |  |
| initContainerResources.limits.cpu | string | `"100m"` |  |
| initContainerResources.limits.memory | string | `"64Mi"` |  |
| initContainerResources.requests.cpu | string | `"10m"` |  |
| initContainerResources.requests.memory | string | `"32Mi"` |  |
| nameOverride | string | `""` |  |
| networkPolicy.egress | list | `[]` |  |
| networkPolicy.egressDNS | bool | `true` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.ingress | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `false` |  |
| persistence.config.size | string | `"1Gi"` |  |
| podAnnotations | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podDisruptionBudget.minAvailable | int | `1` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `977` |  |
| podSecurityContext.runAsGroup | int | `977` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `977` |  |
| replicaCount | int | `1` |  |
| resources.requests.cpu | string | `"50m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| revisionHistoryLimit | int | `3` |  |
| route.annotations | object | `{}` |  |
| route.enabled | bool | `false` |  |
| route.hostnames[0] | string | `"searxng.local"` |  |
| route.parentRefs[0].name | string | `"gateway"` |  |
| route.parentRefs[0].namespace | string | `"default"` |  |
| route.parentRefs[0].sectionName | string | `"https"` |  |
| route.rules[0].matches[0].path.type | string | `"PathPrefix"` |  |
| route.rules[0].matches[0].path.value | string | `"/"` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.annotations | object | `{}` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| serviceMonitor.basicAuth | object | `{}` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.honorLabels | bool | `false` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.labels | object | `{}` |  |
| serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| tolerations | list | `[]` |  |
| valkey.enabled | bool | `false` |  |
| valkey.master.persistence.enabled | bool | `true` |  |
| valkey.master.persistence.size | string | `"1Gi"` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
