# archiva

![Version: 0.0.4](https://img.shields.io/badge/Version-0.0.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.2.5](https://img.shields.io/badge/AppVersion-v2.2.5-informational?style=flat-square)

Helm chart to deploy [archiva](https://hub.docker.com/r/xetusoss/archiva/).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/archiva>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | valentin.fedoskin@gmail.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
| archivaConf | string | `"<configuration>\n    <remoteRepositories>\n        <remoteRepository>\n            <url>https://repo.maven.apache.org/maven2</url>\n            <downloadRemoteIndex>false</downloadRemoteIndex>\n            <downloadRemoteIndexOnStartup>false</downloadRemoteIndexOnStartup>\n            <id>central</id>\n            <name>Central Repository</name>\n        </remoteRepository>\n        <remoteRepository>\n            <url>https://plugins.gradle.org/m2</url>\n            <downloadRemoteIndex>false</downloadRemoteIndex>\n            <downloadRemoteIndexOnStartup>false</downloadRemoteIndexOnStartup>\n            <id>gradle</id>\n            <name>Gradle Plugins Repository</name>\n        </remoteRepository>\n    </remoteRepositories>\n    <proxyConnectors>\n        <proxyConnector>\n            <order>1</order>\n            <sourceRepoId>internal</sourceRepoId>\n            <targetRepoId>central</targetRepoId>\n            <proxyId/>\n            <whiteListPatterns>\n                <whiteListPattern>**/*</whiteListPattern>\n            </whiteListPatterns>\n            <policies>\n                <releases>once</releases>\n                <checksum>fix</checksum>\n                <snapshots>never</snapshots>\n                <cache-failures>yes</cache-failures>\n            </policies>\n            <disabled>false</disabled>\n        </proxyConnector>\n        <proxyConnector>\n            <order>2</order>\n            <sourceRepoId>internal</sourceRepoId>\n            <targetRepoId>gradle</targetRepoId>\n            <proxyId/>\n            <whiteListPatterns>\n                <whiteListPattern>**/*</whiteListPattern>\n            </whiteListPatterns>\n            <policies>\n                <releases>once</releases>\n                <checksum>fix</checksum>\n                <snapshots>never</snapshots>\n                <cache-failures>yes</cache-failures>\n            </policies>\n            <disabled>false</disabled>\n        </proxyConnector>\n    </proxyConnectors>\n</configuration>"` | archiva config to provision inside of the container |
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
