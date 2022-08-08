# docker-registry

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.8.1](https://img.shields.io/badge/AppVersion-2.8.1-informational?style=flat-square)

Helm chart to deploy [docker-registry](https://github.com/distribution/distribution).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/docker-registry>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | <valentin.fedoskin@gmail.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalResources | list | `[]` | list of additional resources to create (are processed via `tpl` function) |
| affinity | object | `{}` | affinity for scheduler pod assignment |
| config | string | `"http:\n  addr: :5000"` | docker-registry config to provision inside of the container |
| containerPorts | list | `[{"containerPort":5000,"name":"http","protocol":"TCP"}]` | ports exposed by container |
| deploymentAnnotations | object | `{}` | annotations to add to the deployment |
| env | list | `[]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| garbageCollectCronJob.deleteUntagged | bool | `true` | delete manifests that are not currently referenced via tag |
| garbageCollectCronJob.dryRun | bool | `false` | do everything except remove the blobs |
| garbageCollectCronJob.failedJobsHistoryLimit | int | `1` | the number of failed finished jobs to retain |
| garbageCollectCronJob.resources | object | `{}` | custom resource configuration |
| garbageCollectCronJob.restartPolicy | string | `"Never"` | container restart policy |
| garbageCollectCronJob.schedule | string | `"@daily"` | the schedule in Cron format, see https://en.wikipedia.org/wiki/Cron |
| garbageCollectCronJob.successfulJobsHistoryLimit | int | `3` | the number of successful finished jobs to retain |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"registry"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| replicaCount | int | `1` | number of replicas for docker-registry deployment. |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.annotations | object | `{}` | annotations to add to the service |
| service.loadBalancerSourceRanges | list | `[]` | traffic through the load-balancer will be restricted to the specified client IPs |
| service.ports | list | `[{"name":"http","port":80,"protocol":"TCP","targetPort":"http"}]` | service ports |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | additional volumes |
