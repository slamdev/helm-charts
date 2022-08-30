# gitlab-runner

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v15.3.0](https://img.shields.io/badge/AppVersion-v15.3.0-informational?style=flat-square)

Helm chart to deploy [gitlab-runner](https://gitlab.com/gitlab-org/gitlab-runner).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/gitlab-runner>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | <valentin.fedoskin@gmail.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers | list | `[]` | extra containers |
| additionalResources | list | `[]` | list of additional resources to create (are processed via `tpl` function) |
| affinity | object | `{}` | affinity for scheduler pod assignment |
| config | string | `"[[runners]]\nexecutor = \"shell\""` | gitlab-runner config |
| env | list | `[]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"gitlab/gitlab-runner"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| livenessProbe.httpGet.path | string | `"/debug/jobs/list"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http-metrics"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/debug/jobs/list"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http-metrics"` | port for readiness probe |
| replicaCount | int | `1` | number of replicas for gitlab-runner deployment. |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.ports | list | `[{"name":"http-metrics","port":80,"targetPort":"http-metrics"}]` | service ports |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| strategy | object | `{}` | deployment strategy |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | additional volumes |
