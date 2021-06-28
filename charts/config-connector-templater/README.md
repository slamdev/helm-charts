# config-connector-templater

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.3](https://img.shields.io/badge/AppVersion-0.0.3-informational?style=flat-square)

Helm chart to deploy [config-connector-templater](https://github.com/slamdev/config-connector-templater).

Kubernetes operator that templates GCP Config Connector resources.

Refer to operator repo for additional information.

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/config-connector-templater>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | valentin.fedoskin@gmail.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for scheduler pod assignment |
| env | list | `[]` | additional environment variables for the deployment |
| fullnameOverride | string | `""` | full name of the chart. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"slamdev/config-connector-templater"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector.node_pool | string | `"preemptible"` |  |
| resources.requests.cpu | string | `"200m"` |  |
| resources.requests.memory | string | `"64Mi"` |  |
| tolerations[0].effect | string | `"NoSchedule"` |  |
| tolerations[0].key | string | `"preemptible"` |  |
| tolerations[0].operator | string | `"Equal"` |  |
| tolerations[0].value | string | `"true"` |  |
