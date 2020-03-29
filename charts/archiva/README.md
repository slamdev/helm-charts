archiva
=======
Helm chart to deploy [archiva](https://hub.docker.com/r/xetusoss/archiva/).

Current chart version is `0.0.1`

Source code can be found [here](https://github.com/slamdev/helm-charts/tree/master/charts/archiva)



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
| archivaConf | string | `"\u003cconfiguration\u003e\n    \u003cremoteRepositories\u003e\n        \u003cremoteRepository\u003e\n            \u003curl\u003ehttps://repo.maven.apache.org/maven2\u003c/url\u003e\n            \u003cdownloadRemoteIndex\u003efalse\u003c/downloadRemoteIndex\u003e\n            \u003cdownloadRemoteIndexOnStartup\u003efalse\u003c/downloadRemoteIndexOnStartup\u003e\n            \u003cid\u003ecentral\u003c/id\u003e\n            \u003cname\u003eCentral Repository\u003c/name\u003e\n        \u003c/remoteRepository\u003e\n        \u003cremoteRepository\u003e\n            \u003curl\u003ehttps://plugins.gradle.org/m2\u003c/url\u003e\n            \u003cdownloadRemoteIndex\u003efalse\u003c/downloadRemoteIndex\u003e\n            \u003cdownloadRemoteIndexOnStartup\u003efalse\u003c/downloadRemoteIndexOnStartup\u003e\n            \u003cid\u003egradle\u003c/id\u003e\n            \u003cname\u003eGradle Plugins Repository\u003c/name\u003e\n        \u003c/remoteRepository\u003e\n    \u003c/remoteRepositories\u003e\n    \u003cproxyConnectors\u003e\n        \u003cproxyConnector\u003e\n            \u003corder\u003e1\u003c/order\u003e\n            \u003csourceRepoId\u003einternal\u003c/sourceRepoId\u003e\n            \u003ctargetRepoId\u003ecentral\u003c/targetRepoId\u003e\n            \u003cproxyId/\u003e\n            \u003cwhiteListPatterns\u003e\n                \u003cwhiteListPattern\u003e**/*\u003c/whiteListPattern\u003e\n            \u003c/whiteListPatterns\u003e\n            \u003cpolicies\u003e\n                \u003creleases\u003eonce\u003c/releases\u003e\n                \u003cchecksum\u003efix\u003c/checksum\u003e\n                \u003csnapshots\u003enever\u003c/snapshots\u003e\n                \u003ccache-failures\u003eyes\u003c/cache-failures\u003e\n            \u003c/policies\u003e\n            \u003cdisabled\u003efalse\u003c/disabled\u003e\n        \u003c/proxyConnector\u003e\n        \u003cproxyConnector\u003e\n            \u003corder\u003e2\u003c/order\u003e\n            \u003csourceRepoId\u003einternal\u003c/sourceRepoId\u003e\n            \u003ctargetRepoId\u003egradle\u003c/targetRepoId\u003e\n            \u003cproxyId/\u003e\n            \u003cwhiteListPatterns\u003e\n                \u003cwhiteListPattern\u003e**/*\u003c/whiteListPattern\u003e\n            \u003c/whiteListPatterns\u003e\n            \u003cpolicies\u003e\n                \u003creleases\u003eonce\u003c/releases\u003e\n                \u003cchecksum\u003efix\u003c/checksum\u003e\n                \u003csnapshots\u003enever\u003c/snapshots\u003e\n                \u003ccache-failures\u003eyes\u003c/cache-failures\u003e\n            \u003c/policies\u003e\n            \u003cdisabled\u003efalse\u003c/disabled\u003e\n        \u003c/proxyConnector\u003e\n    \u003c/proxyConnectors\u003e\n\u003c/configuration\u003e"` | archiva config to provision inside of the container |
| env | list | `[{"name":"DB_TYPE","value":"derby"}]` | environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"xetusoss/archiva"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| ingress.annotations | object | `{}` | ingress annotations |
| ingress.enabled | bool | `false` | enables Ingress for archiva |
| ingress.hosts | list | `[]` | ingress accepted hostnames |
| ingress.tls | list | `[]` | ingress TLS configuration |
| livenessProbe.exec.command | list | `["/healthcheck.sh"]` | command for liveness probe |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| readinessProbe.exec.command | list | `["/healthcheck.sh"]` | command for readiness probe |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.port | int | `80` | service port |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeMounts | list | `[{"mountPath":"/archiva-data","name":"data"}]` | volume mounts |
| volumes | list | `[{"emptyDir":{},"name":"data"}]` | volumes |
