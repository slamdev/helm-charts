# buildbarn

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2022-02-12](https://img.shields.io/badge/AppVersion-2022--02--12-informational?style=flat-square)

Helm chart to deploy [buildbarn](https://github.com/buildbarn).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/buildbarn>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | valentin.fedoskin@gmail.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| browser.affinity | object | `{}` | affinity for scheduler pod assignment |
| browser.conf | string | `"local common = import 'common.libsonnet';\n{\n  blobstore: common.blobstore,\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n  listenAddress: common.httpListenAddress,\n}"` | config https://github.com/buildbarn/bb-browser/blob/547095cf8540c671b0f2291b1e6f76081e47a9fc/pkg/proto/configuration/bb_browser/bb_browser.proto |
| browser.containerPort | int | `80` | port exposed by container |
| browser.enabled | bool | `false` | enable browser component |
| browser.env | list | `[]` | environment variables for the deployment |
| browser.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| browser.image.repository | string | `"buildbarn/bb-browser"` | image repository |
| browser.image.tag | string | `"20211222T121123Z-547095c"` | image tag |
| browser.ingress.annotations | object | `{}` | ingress annotations |
| browser.ingress.enabled | bool | `false` | enables Ingress |
| browser.ingress.hosts | list | `[]` | ingress accepted hostnames |
| browser.ingress.tls | list | `[]` | ingress TLS configuration |
| browser.livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| browser.livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| browser.nodeSelector | object | `{}` | node for scheduler pod assignment |
| browser.podSecurityContext | object | `{}` | specifies security settings for a pod |
| browser.readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| browser.readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| browser.replicaCount | int | `1` | number of replicas for the deployment. |
| browser.resources | object | `{}` | custom resource configuration |
| browser.securityContext | object | `{}` | specifies security settings for a container |
| browser.service.name | string | `"http"` | service name |
| browser.service.port | int | `80` | service port |
| browser.service.type | string | `"ClusterIP"` | service type |
| browser.serviceMonitor.additionalLabels | object | `{}` | additional labels for service monitor |
| browser.serviceMonitor.enabled | bool | `false` | ServiceMonitor CRD is created for a prometheus operator |
| browser.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| browser.volumeMounts | list | `[]` | volume mounts |
| browser.volumes | list | `[]` | volumes |
| commonConf | string | `"{\n  blobstore: {\n    contentAddressableStorage: {\n      sharding: {\n        hashInitialization: 11946695773637837490,\n        shards: [\n          {\n            backend: { grpc: { address: 'storage-0.storage.buildbarn:8981' } },\n            weight: 1,\n          },\n          {\n            backend: { grpc: { address: 'storage-1.storage.buildbarn:8981' } },\n            weight: 1,\n          },\n        ],\n      },\n    },\n    actionCache: {\n      completenessChecking: {\n        sharding: {\n          hashInitialization: 14897363947481274433,\n          shards: [\n            {\n              backend: { grpc: { address: 'storage-0.storage.buildbarn:8981' } },\n              weight: 1,\n            },\n            {\n              backend: { grpc: { address: 'storage-1.storage.buildbarn:8981' } },\n              weight: 1,\n            },\n          ],\n        },\n      },\n    },\n  },\n  # Remember to set your browserUrl to the ingress of the browser deployment\n  # browserUrl: 'http://address-of-bb-browser-ingress:80',\n  maximumMessageSizeBytes: 16 * 1024 * 1024,\n  httpListenAddress: ':80'\n}"` |  |
| frontend.affinity | object | `{}` | affinity for scheduler pod assignment |
| frontend.conf | string | `"local common = import 'common.libsonnet';\n{\n  blobstore: common.blobstore,\n  httpListenAddress: common.httpListenAddress,\n  grpcServers: [{\n    listenAddresses: [':8980'],\n    authenticationPolicy: { allow: {} },\n  }],\n  schedulers: {\n    '': { endpoint: { address: 'scheduler:8982' } },\n  },\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n}"` | config https://github.com/buildbarn/bb-frontend/blob/547095cf8540c671b0f2291b1e6f76081e47a9fc/pkg/proto/configuration/bb_frontend/bb_frontend.proto |
| frontend.containerGrpcPort | int | `8980` | grpc port exposed by container |
| frontend.containerHttpPort | int | `80` | http port exposed by container |
| frontend.enabled | bool | `false` | enable frontend component |
| frontend.env | list | `[]` | environment variables for the deployment |
| frontend.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| frontend.livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| frontend.livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| frontend.nodeSelector | object | `{}` | node for scheduler pod assignment |
| frontend.podSecurityContext | object | `{}` | specifies security settings for a pod |
| frontend.readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| frontend.readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| frontend.replicaCount | int | `1` | number of replicas for the deployment. |
| frontend.resources | object | `{}` | custom resource configuration |
| frontend.securityContext | object | `{}` | specifies security settings for a container |
| frontend.service.grpc.name | string | `"grpc"` | grpc service name |
| frontend.service.grpc.port | int | `8980` | grpc service port |
| frontend.service.http.name | string | `"http"` | http service name |
| frontend.service.http.port | int | `80` | http service port |
| frontend.service.type | string | `"ClusterIP"` | service type |
| frontend.serviceMonitor.additionalLabels | object | `{}` | additional labels for service monitor |
| frontend.serviceMonitor.enabled | bool | `false` | ServiceMonitor CRD is created for a prometheus operator |
| frontend.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| frontend.volumeMounts | list | `[]` | volume mounts |
| frontend.volumes | list | `[]` | volumes |
| fullnameOverride | string | `""` | full name of the chart. |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| nameOverride | string | `""` | override name of the chart |
| scheduler.affinity | object | `{}` | affinity for scheduler pod assignment |
| scheduler.conf | string | `"local common = import 'common.libsonnet';\n{\n  httpListenAddress: common.httpListenAddress,\n  clientGrpcServers: [{\n    listenAddresses: [':8982'],\n    authenticationPolicy: { allow: {} },\n  }],\n  workerGrpcServers: [{\n    listenAddresses: [':8983'],\n    authenticationPolicy: { allow: {} },\n  }],\n  contentAddressableStorage: common.blobstore.contentAddressableStorage,\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n  browserUrl: common.browserUrl,\n}"` | config https://github.com/buildbarn/bb-scheduler/blob/547095cf8540c671b0f2291b1e6f76081e47a9fc/pkg/proto/configuration/bb_scheduler/bb_scheduler.proto |
| scheduler.containerGrpcClientPort | int | `8982` | client grpc port exposed by container |
| scheduler.containerGrpcWorkerPort | int | `8983` | worker grpc port exposed by container |
| scheduler.containerHttpPort | int | `80` | http port exposed by container |
| scheduler.enabled | bool | `false` | enable scheduler component |
| scheduler.env | list | `[]` | environment variables for the deployment |
| scheduler.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| scheduler.image.repository | string | `"buildbarn/bb-scheduler"` | image repository |
| scheduler.image.tag | string | `"20220211T141613Z-74b54e3"` | image tag |
| scheduler.livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| scheduler.livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| scheduler.nodeSelector | object | `{}` | node for scheduler pod assignment |
| scheduler.podSecurityContext | object | `{}` | specifies security settings for a pod |
| scheduler.readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| scheduler.readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| scheduler.replicaCount | int | `1` | number of replicas for the deployment. |
| scheduler.resources | object | `{}` | custom resource configuration |
| scheduler.securityContext | object | `{}` | specifies security settings for a container |
| scheduler.service.grpcClient.name | string | `"grpc"` | grpc client service name |
| scheduler.service.grpcClient.port | int | `8982` | grpc client service port |
| scheduler.service.grpcWorker.name | string | `"grpc"` | grpc worker service name |
| scheduler.service.grpcWorker.port | int | `8983` | grpc worker service port |
| scheduler.service.http.name | string | `"http"` | http service name |
| scheduler.service.http.port | int | `80` | http service port |
| scheduler.service.type | string | `"ClusterIP"` | service type |
| scheduler.serviceMonitor.additionalLabels | object | `{}` | additional labels for service monitor |
| scheduler.serviceMonitor.enabled | bool | `false` | ServiceMonitor CRD is created for a prometheus operator |
| scheduler.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| scheduler.volumeMounts | list | `[]` | volume mounts |
| scheduler.volumes | list | `[]` | volumes |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| worker.affinity | object | `{}` | affinity for scheduler pod assignment |
| worker.enabled | bool | `true` | enable worker component |
| worker.env | list | `[]` | environment variables for the deployment |
| worker.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| worker.image.runnerInstaller.repository | string | `"buildbarn/bb-runner-installer"` | image repository |
| worker.image.runnerInstaller.tag | string | `"20220211T141613Z-74b54e3"` | image tag |
| worker.image.worker.repository | string | `"buildbarn/bb-worker"` | image repository |
| worker.image.worker.tag | string | `"20220211T141613Z-74b54e3"` | image tag |
| worker.nodeSelector | object | `{}` | node for scheduler pod assignment |
| worker.podSecurityContext | object | `{}` | specifies security settings for a pod |
| worker.replicaCount | int | `1` | number of replicas for the deployment. |
| worker.runnerConf | string | `"{\n  buildDirectoryPath: '/worker/build',\n  grpcServers: [{\n    listenPaths: ['/worker/runner'],\n    authenticationPolicy: { allow: {} },\n  }],\n}"` | config https://github.com/buildbarn/bb-worker/blob/547095cf8540c671b0f2291b1e6f76081e47a9fc/pkg/proto/configuration/bb_worker/bb_worker.proto |
| worker.runnerContainer.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| worker.runnerContainer.image.repository | string | `"l.gcr.io/google/rbe-ubuntu16-04"` | image repository |
| worker.runnerContainer.image.tag | string | `"latest@sha256:b516a2d69537cb40a7c6a7d92d0008abb29fba8725243772bdaf2c83f1be2272"` | image tag |
| worker.runnerContainer.resources | object | `{}` | custom resource configuration |
| worker.runnerContainer.securityContext | object | `{"allowPrivilegeEscalation":false,"runAsUser":65534}` | specifies security settings for a container |
| worker.service.name | string | `"http"` | service name |
| worker.service.port | int | `80` | service port |
| worker.service.type | string | `"ClusterIP"` | service type |
| worker.serviceMonitor.additionalLabels | object | `{}` | additional labels for service monitor |
| worker.serviceMonitor.enabled | bool | `false` | ServiceMonitor CRD is created for a prometheus operator |
| worker.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| worker.volumeMounts | list | `[]` | volume mounts |
| worker.volumes | list | `[]` | volumes |
| worker.workerConf | string | `"local common = import 'common.libsonnet';\n{\n  blobstore: common.blobstore,\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n  scheduler: { address: 'scheduler:8983' },\n  httpListenAddress: common.httpListenAddress,\n  maximumMemoryCachedDirectories: 1000,\n  instanceName: 'remote-execution',\n  browserUrl: common.browserUrl,\n  buildDirectories: [{\n    native: {\n      buildDirectoryPath: '/worker/build',\n      cacheDirectoryPath: '/worker/cache',\n      maximumCacheFileCount: 10000,\n      maximumCacheSizeBytes: 1024 * 1024 * 1024,\n      cacheReplacementPolicy: 'LEAST_RECENTLY_USED',\n    },\n    runners: [{\n      endpoint: { address: 'unix:///worker/runner' },\n      concurrency: 8,\n      platform: {\n        properties: [\n          { name: 'OSFamily', value: 'Linux' },\n          { name: 'container-image', value: 'docker://marketplace.gcr.io/google/rbe-ubuntu16-04@sha256:b516a2d69537cb40a7c6a7d92d0008abb29fba8725243772bdaf2c83f1be2272' },\n        ],\n      },\n      defaultExecutionTimeout: '1800s',\n      maximumExecutionTimeout: '3600s',\n      workerId: {\n        'pod': std.extVar(\"POD_NAME\"),\n        'node': std.extVar(\"NODE_NAME\")\n      },\n    }],\n  }],\n}"` | config https://github.com/buildbarn/bb-worker/blob/547095cf8540c671b0f2291b1e6f76081e47a9fc/pkg/proto/configuration/bb_worker/bb_worker.proto |
| worker.workerContainer.containerPort | int | `80` | port exposed by container |
| worker.workerContainer.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| worker.workerContainer.image.repository | string | `"buildbarn/bb-worker"` | image repository |
| worker.workerContainer.image.tag | string | `"20220211T141613Z-74b54e3"` | image tag |
| worker.workerContainer.livenessProbe.httpGet.path | string | `"/"` | path for liveness probe |
| worker.workerContainer.livenessProbe.httpGet.port | string | `"http"` | port for liveness probe |
| worker.workerContainer.readinessProbe.httpGet.path | string | `"/"` | path for readiness probe |
| worker.workerContainer.readinessProbe.httpGet.port | string | `"http"` | port for readiness probe |
| worker.workerContainer.resources | object | `{}` | custom resource configuration |
| worker.workerContainer.securityContext | object | `{}` | specifies security settings for a container |
