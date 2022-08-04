# docker-registry-ui

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.9.4](https://img.shields.io/badge/AppVersion-0.9.4-informational?style=flat-square)

Helm chart to deploy [docker-registry-ui](https://github.com/Quiq/docker-registry-ui).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/docker-registry-ui>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | <valentin.fedoskin@gmail.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalResources | list | `[]` | list of additional resources to create (are processed via `tpl` function) |
| affinity | object | `{}` | affinity for scheduler pod assignment |
| config | string | `"listen_addr: 0.0.0.0:8000\nbase_path: /\nregistry_url: http://registry:5000\nevent_listener_token: token\nanyone_can_delete: true\nevent_database_driver: sqlite3"` | docker-registry-ui config to provision inside of the container |
| containerPorts | list | `[{"containerPort":8000,"name":"http","protocol":"TCP"}]` | ports exposed by container |
| env | list | `[]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"quiq/docker-registry-ui"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| replicaCount | int | `1` | number of replicas for docker-registry-ui deployment. |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.ports | list | `[{"name":"http","port":80,"protocol":"TCP","targetPort":"http"}]` | service ports |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | additional volumes |
