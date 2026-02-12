# etcd

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v3.5.26](https://img.shields.io/badge/AppVersion-v3.5.26-informational?style=flat-square)

Production-ready etcd cluster with S3 backup support

**Homepage:** <https://etcd.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| UnknownIQ |  |  |

## Source Code

* <https://github.com/etcd-io/etcd>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"etcd"` |  |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"kubernetes.io/hostname"` |  |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `100` |  |
| auth.enabled | bool | `false` |  |
| auth.existingSecret | string | `""` |  |
| auth.rootPassword | string | `""` |  |
| backup.enabled | bool | `true` |  |
| backup.resources.limits.cpu | string | `"500m"` |  |
| backup.resources.limits.memory | string | `"512Mi"` |  |
| backup.resources.requests.cpu | string | `"100m"` |  |
| backup.resources.requests.memory | string | `"256Mi"` |  |
| backup.retention.days | int | `7` |  |
| backup.retention.months | int | `3` |  |
| backup.retention.weeks | int | `4` |  |
| backup.s3.accessKey | string | `""` |  |
| backup.s3.bucket | string | `""` |  |
| backup.s3.endpoint | string | `""` |  |
| backup.s3.existingSecret | string | `""` |  |
| backup.s3.prefix | string | `"etcd-backups"` |  |
| backup.s3.region | string | `"us-east-1"` |  |
| backup.s3.secretKey | string | `""` |  |
| backup.schedule | string | `"0 */6 * * *"` |  |
| defrag.enabled | bool | `true` |  |
| defrag.resources.requests.cpu | string | `"100m"` |  |
| defrag.resources.requests.memory | string | `"128Mi"` |  |
| defrag.schedule | string | `"0 0 * * 0"` |  |
| etcd.autoCompactionMode | string | `"periodic"` |  |
| etcd.autoCompactionRetention | string | `"1h"` |  |
| etcd.electionTimeout | int | `1000` |  |
| etcd.heartbeatInterval | int | `100` |  |
| etcd.initialClusterState | string | `"new"` |  |
| etcd.initialClusterToken | string | `""` |  |
| etcd.logLevel | string | `"info"` |  |
| etcd.quotaBackendBytes | string | `"2147483648"` |  |
| etcd.snapshotCount | int | `10000` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.registry | string | `"gcr.io"` |  |
| image.repository | string | `"etcd-development/etcd"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| networkPolicy.egress | list | `[]` |  |
| networkPolicy.egressDNS | bool | `true` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.ingress | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.size | string | `"8Gi"` |  |
| persistence.storageClass | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `true` |  |
| podDisruptionBudget.maxUnavailable | int | `1` |  |
| podDisruptionBudget.minAvailable | string | `""` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1001` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `1001` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `1001` |  |
| replicaCount | int | `3` |  |
| resources.limits.cpu | string | `"1000m"` |  |
| resources.limits.memory | string | `"512Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| revisionHistoryLimit | int | `3` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.annotations | object | `{}` |  |
| service.clientPort | int | `2379` |  |
| service.peerPort | int | `2380` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.honorLabels | bool | `false` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.labels | object | `{}` |  |
| serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| tls.client.caFilename | string | `"ca.crt"` |  |
| tls.client.certFilename | string | `"tls.crt"` |  |
| tls.client.existingSecret | string | `""` |  |
| tls.client.keyFilename | string | `"tls.key"` |  |
| tls.enabled | bool | `false` |  |
| tls.peer.caFilename | string | `"ca.crt"` |  |
| tls.peer.certFilename | string | `"tls.crt"` |  |
| tls.peer.existingSecret | string | `""` |  |
| tls.peer.keyFilename | string | `"tls.key"` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
