# bazel-remote

![Version: 0.0.3](https://img.shields.io/badge/Version-0.0.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.2.0](https://img.shields.io/badge/AppVersion-v2.2.0-informational?style=flat-square)

Helm chart to deploy [bazel-remote](https://github.com/buchgr/bazel-remote).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/bazel-remote>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | valentin.fedoskin@gmail.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
| conf | string | `"# https://github.com/buchgr/bazel-remote#example-configuration-file\ndir: /cache\nmax_size: 50\nexperimental_remote_asset_api: true\naccess_log_level: none\nport: 8080\ngrpc_port: 9092"` | bazel-remote config to provision inside of the container |
| containerPorts | list | `[{"containerPort":8080,"name":"http"},{"containerPort":9092,"name":"grpc"}]` | ports exposed by container |
| deploymentAnnotations | object | `{}` | annotations to add to the deployment |
| env | list | `[]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"buchgr/bazel-remote-cache"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| kind | string | `"Deployment"` | resource type to operate bazel-remote, can be StatefulSet or Deployment |
| livenessProbe.httpGet.path | string | `"/status"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podAnnotations | object | `{}` | annotations to add to the pod |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/status"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| replicaCount | int | `1` | number of replicas for bazel-remote deployment. |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.ports | list | `[{"name":"http","port":80,"targetPort":"http"},{"name":"grpc","port":9092,"targetPort":"grpc"}]` | service ports |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| serviceMonitor.additionalLabels | object | `{}` | additional labels for service monitor |
| serviceMonitor.enabled | bool | `false` | ServiceMonitor CRD is created for a prometheus operator |
| startupProbe.httpGet.path | string | `"/status"` |  |
| startupProbe.httpGet.port | string | `"http"` |  |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeClaimTemplates | list | `[]` | volume claim templates; used only when 'kind: StatefulSet' |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | additional volumes |
