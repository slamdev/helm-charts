# gradle-cache

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 11.0](https://img.shields.io/badge/AppVersion-11.0-informational?style=flat-square)

Helm chart to deploy [gradle-cache](https://docs.gradle.com/build-cache-node/).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/gradle-cache>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | valentin.fedoskin@gmail.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
| args | list | `["start","--no-warn-anon-cache-write","--no-warn-anon-ui-access"]` | args to pass to the container |
| configSecret.content | string | `"version: 4\ncache:\n  accessControl:\n    anonymousLevel: readwrite\n  maxEntryAgeInHours: null\n  freeSpaceBufferSize: 1024\n  maxArtifactSize: 100\n  targetSize:\n    type: fixed\n    size: 10000\nuiAccess:\n  type: open"` |  |
| configSecret.create | bool | `true` | specifies whether a secret should be created |
| configSecret.name | string | `nil` | the name of the secret to use; if not set and create is true, a name is generated using the fullname template |
| env | list | `[]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"gradle/build-cache-node"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| ingress.annotations | object | `{}` | ingress annotations |
| ingress.enabled | bool | `false` | enables Ingress for gradle-cache |
| ingress.hosts | list | `[]` | ingress accepted hostnames |
| ingress.tls | list | `[]` | ingress TLS configuration |
| livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.annotations | object | `{}` | service annotations |
| service.port | int | `80` | service port |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumes | list | `[{"emptyDir":{},"name":"cache"}]` | volumes |
