# nginx

![Version: 0.0.21](https://img.shields.io/badge/Version-0.0.21-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.19.10](https://img.shields.io/badge/AppVersion-1.19.10-informational?style=flat-square)

Helm chart to deploy [nginx](https://www.nginx.com).

Chart supports environment variables inside of the nginx.conf file.

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/nginx>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | <valentin.fedoskin@gmail.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalLabels | object | `{}` | Custom labels to add into metadata |
| affinity | object | `{}` | affinity for scheduler pod assignment |
| deploymentAnnotations | object | `{}` | annotations to add to the deployment |
| dnsmasq.enabled | bool | `false` | enable simple dns server for nginx |
| env | list | `[]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"nginx"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| ingress.annotations | object | `{}` | ingress annotations |
| ingress.enabled | bool | `false` | enables Ingress for nginx |
| ingress.hosts | list | `[]` | ingress accepted hostnames |
| ingress.tls | list | `[]` | ingress TLS configuration |
| livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nginxConf | string | `"# nginx version: ENV_NGINX_VERSION_ENV\nuser             nginx;\nworker_processes auto;\nerror_log        /var/log/nginx/error.log warn;\npid              /var/run/nginx.pid;\nevents {\n    worker_connections 1024;\n}\nhttp {\n    include           /etc/nginx/mime.types;\n    default_type      application/octet-stream;\n    log_format        main '$remote_addr - $remote_user [$time_local] \"$request\" '\n                           '$status $body_bytes_sent \"$http_referer\" '\n                           '\"$http_user_agent\" \"$http_x_forwarded_for\" '\n                           '$request_time $upstream_response_time $pipe';\n    access_log        /var/log/nginx/access.log main;\n    sendfile          on;\n    keepalive_timeout 65;\n    server {\n        listen      80;\n        server_name localhost;\n        location / {\n            default_type text/plain;\n            access_log   off;\n            error_log    off;\n            return 200   'ok';\n        }\n    }\n}"` | nginx config to provision inside of the container |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podAnnotations | object | `{}` | annotations to add to the pod |
| podDisruptionBudget | object | `{}` | disruption budget for pod |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| replicaCount | int | `1` | number of replicas for nginx deployment. |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.port | int | `80` | service port |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| useDebugBinary | bool | `false` | run nginx-debug binary instead of normal one |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | additional volumes |
