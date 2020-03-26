gradle-cache
============
Helm chart to deploy [gradle-cache](https://docs.gradle.com/build-cache-node/).

Current chart version is `0.0.3`

Source code can be found [here](https://github.com/slamdev/helm-charts/tree/master/charts/gradle-cache)



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
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
| service.port | int | `80` | service port |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | additional volumes |
