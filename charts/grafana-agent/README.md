# grafana-agent

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.26.1](https://img.shields.io/badge/AppVersion-v0.26.1-informational?style=flat-square)

Helm chart to deploy [grafana-agent](https://github.com/grafana/agent).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/grafana-agent>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | <valentin.fedoskin@gmail.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalResources | list | `[]` | list of additional resources to create (are processed via `tpl` function) |
| affinity | object | `{}` | affinity for scheduler pod assignment |
| args[0] | string | `"--config.file=/grafana-agent.yaml"` |  |
| conf | string | `"server:\n  log_level: info"` | grafana-agent config to provision inside of the container |
| containerPorts | list | `[{"containerPort":12345,"name":"http"},{"containerPort":12346,"name":"grpc"}]` | ports exposed by container |
| env | list | `[{"name":"HOSTNAME","valueFrom":{"fieldRef":{"fieldPath":"spec.nodeName"}}},{"name":"POD_NAME","valueFrom":{"fieldRef":{"fieldPath":"metadata.name"}}},{"name":"POD_IP","valueFrom":{"fieldRef":{"fieldPath":"status.podIP"}}}]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"grafana/grafana-agent"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| livenessProbe.httpGet.path | string | `"/http-metrics/-/ready"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podAnnotations | object | `{}` | annotations to add to the pod |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/http-metrics/-/ready"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.annotations | object | `{}` | service annotations |
| service.ports | list | `[{"name":"http","port":12345,"targetPort":"http"},{"name":"grpc","port":12346,"targetPort":"grpc"}]` | service ports |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| startupProbe.httpGet.path | string | `"/http-metrics/-/ready"` | path for startup probe |
| startupProbe.httpGet.port | string | `"http"` | port for startup probe |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | additional volumes |
| workload.annotations | object | `{}` | annotations to add to the workload |
| workload.daemonSetSpec.updateStrategy | object | `{}` | an update strategy to replace existing DaemonSet pods with new pods |
| workload.deploymentSpec.replicas | int | `1` | number of desired pods |
| workload.deploymentSpec.strategy | object | `{}` | the deployment strategy to use to replace existing pods with new ones. |
| workload.kind | string | `"deployment"` | can be deployment, statefulSet or daemonSet |
| workload.labels | object | `{}` | labels to add to the workload |
| workload.statefulSetSpec.podManagementPolicy | string | `"OrderedReady"` | controls how pods are created during initial scale up |
| workload.statefulSetSpec.replicas | int | `1` | number of desired pods |
| workload.statefulSetSpec.updateStrategy | object | `{}` | indicates the StatefulSetUpdateStrategy that will be employed to update Pods in the StatefulSet when a revision is made to Template |
| workload.statefulSetSpec.volumeClaimTemplates | object | `{}` | a list of claims that pods are allowed to reference |
