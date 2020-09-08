fluentd
=======
Helm chart to deploy [fluentd](http://www.fluentd.org/).

Current chart version is `0.0.2`

Source code can be found [here](https://github.com/slamdev/helm-charts/tree/master/charts/fluentd)



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
| containerPorts | list | `[{"containerPort":8888,"name":"http","protocol":"TCP"},{"containerPort":24231,"name":"http-monitoring","protocol":"TCP"}]` | ports exposed by container |
| deploymentAnnotations | object | `{}` | annotations to add to the deployment |
| env | list | `[]` | additional environment variables for the deployment |
| fluentdConf | string | `"<source>\n  @type prometheus\n</source>\n<source>\n  @type prometheus_monitor\n</source>\n<source>\n  @type prometheus_output_monitor\n</source>\n<source>\n  @type http\n  port 8888\n</source>"` | fluentd config to provision inside of the container |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"fluent/fluentd-kubernetes-daemonset"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| kind | string | `"Deployment"` | resource type to operate fluentd, can be StatefulSet or Deployment |
| livenessProbe.httpGet.path | string | `"/metrics"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http-monitoring"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podAnnotations | object | `{}` | annotations to add to the pod |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/metrics"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http-monitoring"` | port for readiness probe |
| replicaCount | int | `1` | number of replicas for fluentd deployment. |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.ports | list | `[{"name":"http","port":80,"protocol":"TCP","targetPort":"http"},{"name":"http-monitoring","port":24231,"protocol":"TCP","targetPort":"http-monitoring"}]` | service ports |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| serviceMonitor.additionalLabels | object | `{}` | additional labels for service monitor |
| serviceMonitor.enabled | bool | `false` | ServiceMonitor CRD is created for a prometheus operator |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeClaimTemplates | list | `[]` | volume claim templates; used only when 'kind: StatefulSet' |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | additional volumes |
