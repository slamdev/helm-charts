# haproxy

![Version: 0.0.4](https://img.shields.io/badge/Version-0.0.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.3.9](https://img.shields.io/badge/AppVersion-2.3.9-informational?style=flat-square)

Helm chart to deploy [haproxy](http://www.haproxy.org/).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/haproxy>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | valentin.fedoskin@gmail.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
| containerPorts | list | `[{"containerPort":8000,"name":"http","protocol":"TCP"}]` | ports exposed by container |
| env | list | `[]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| haproxyConf | string | `"global\n    log stdout format raw local0 info\n\ndefaults\n    timeout connect 1s\n    timeout client  1s\n    timeout server  1s\n    log     global\n    option  httplog\n\nfrontend        status-monitor\n    mode        http\n    bind        :8000\n    monitor-uri /"` | haproxy config to provision inside of the container |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"haproxy"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| replicaCount | int | `1` | number of replicas for haproxy deployment. |
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
