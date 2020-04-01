gitlab-omnibus
==============
Helm chart to deploy [Omnibus Gitlab](https://docs.gitlab.com/omnibus/).

Current chart version is `0.0.1`

Source code can be found [here](https://github.com/slamdev/helm-charts/tree/master/charts/gitlab-omnibus)



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
| env | list | `[]` | environment variables for the container |
| envFrom | list | `[]` | environment variable sources for the container |
| fullnameOverride | string | `""` | full name of the chart. |
| gitlabConf | string | `"external_url 'https://gitlab.example.com'\ngitlab_rails['initial_root_password'] = ENV['GITLAB_INITIAL_ROOT_PASSWORD']"` | config for gitlab.rb https://docs.gitlab.com/omnibus/settings/configuration.html |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"gitlab/gitlab"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| livenessProbe.httpGet.path | string | `"/-/liveness"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/-/readiness"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{"privileged":true}` | specifies security settings for a container |
| service.annotations | object | `{}` | service annotations |
| service.loadBalancerIP | string | `nil` | load balancer IP |
| service.ports | list | `[{"name":"http","port":80,"targetPort":"http"},{"name":"https","port":443,"targetPort":"https"},{"name":"ssh","port":22,"targetPort":"ssh"}]` | service ports |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeClaimTemplates | list | `[]` | volume claim templates |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[{"emptyDir":{},"name":"data"},{"emptyDir":{},"name":"config"},{"emptyDir":{},"name":"logs"}]` | volumes |
