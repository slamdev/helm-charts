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
| browser.conf | string | `"local common = import 'common.libsonnet';\n{\n  global: common.global,\n  blobstore: common.blobstore,\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n  listenAddress: common.httpListenAddress,\n  authorizer: common.allowAllauthorizerConfiguration,\n}"` | config https://github.com/buildbarn/bb-browser/blob/547095cf8540c671b0f2291b1e6f76081e47a9fc/pkg/proto/configuration/bb_browser/bb_browser.proto |
| browser.containerPort | int | `80` | port exposed by container |
| browser.enabled | bool | `true` | enable browser component |
| browser.env | list | `[]` | environment variables for the deployment |
| browser.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| browser.image.repository | string | `"buildbarn/bb-browser"` | image repository |
| browser.image.tag | string | `"20211222T121123Z-547095c"` | image tag |
| browser.ingress.annotations | object | `{}` | ingress annotations |
| browser.ingress.enabled | bool | `false` | enables Ingress |
| browser.ingress.hosts | list | `[]` | ingress accepted hostnames |
| browser.ingress.tls | list | `[]` | ingress TLS configuration |
| browser.livenessProbe.httpGet.path | string | `"/-/healthy"` | path for liveness probe |
| browser.livenessProbe.httpGet.port | string | `"http-metrics"` | port for liveness probe |
| browser.nodeSelector | object | `{}` | node for scheduler pod assignment |
| browser.podMonitor.additionalLabels | object | `{}` | additional labels for pod monitor |
| browser.podMonitor.enabled | bool | `false` | PodMonitor CRD is created for a prometheus operator |
| browser.podSecurityContext | object | `{}` | specifies security settings for a pod |
| browser.readinessProbe.httpGet.path | string | `"/-/healthy"` | path for readiness probe |
| browser.readinessProbe.httpGet.port | string | `"http-metrics"` | port for readiness probe |
| browser.replicaCount | int | `1` | number of replicas for the deployment. |
| browser.resources | object | `{}` | custom resource configuration |
| browser.securityContext | object | `{}` | specifies security settings for a container |
| browser.service.name | string | `"http"` | service name |
| browser.service.port | int | `80` | service port |
| browser.service.type | string | `"ClusterIP"` | service type |
| browser.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| browser.volumeMounts | list | `[]` | volume mounts |
| browser.volumes | list | `[]` | volumes |
| commonConf | string | `"{\n  global: {\n    diagnostics_http_server: {\n      listen_address: ':8080',\n      enable_prometheus: true,\n    },\n    setUmask: { umask: 0 },\n  },\n  allowAllauthorizerConfiguration: {\n    allow: {},\n  },\n  blobstore: {\n    contentAddressableStorage: {\n      sharding: {\n        hashInitialization: 11946695773637837490,\n        shards: [\n          {\n            backend: { grpc: { address: 'buildbarn-storage-0.buildbarn-storage:8981' } },\n            weight: 1,\n          },\n          {\n            backend: { grpc: { address: 'buildbarn-storage-1.buildbarn-storage:8981' } },\n            weight: 1,\n          },\n        ],\n      },\n    },\n    actionCache: {\n      completenessChecking: {\n        sharding: {\n          hashInitialization: 14897363947481274433,\n          shards: [\n            {\n              backend: { grpc: { address: 'buildbarn-storage-0.buildbarn-storage:8981' } },\n              weight: 1,\n            },\n            {\n              backend: { grpc: { address: 'buildbarn-storage-1.buildbarn-storage:8981' } },\n              weight: 1,\n            },\n          ],\n        },\n      },\n    },\n  },\n  # Remember to set your browserUrl to the ingress of the browser deployment\n  browserUrl: 'http://buildbarn-browser:80',\n  maximumMessageSizeBytes: 16 * 1024 * 1024,\n  httpListenAddress: ':80'\n}"` |  |
| containerMetricsPort | int | `8080` |  |
| frontend.affinity | object | `{}` | affinity for scheduler pod assignment |
| frontend.conf | string | `"local common = import 'common.libsonnet';\n{\n  global: common.global,\n  blobstore: common.blobstore,\n  grpcServers: [{\n    listenAddresses: [':8980'],\n    authenticationPolicy: common.allowAllauthorizerConfiguration,\n  }],\n  schedulers: {\n    '': { endpoint: { address: 'buildbarn-scheduler:8982' } },\n  },\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n  contentAddressableStorageAuthorizers: {\n    get: common.allowAllauthorizerConfiguration,\n    put: common.allowAllauthorizerConfiguration,\n    findMissing: common.allowAllauthorizerConfiguration,\n  },\n  actionCacheAuthorizers: {\n    get: common.allowAllauthorizerConfiguration,\n    put: common.allowAllauthorizerConfiguration,\n  },\n  execute_authorizer: common.allowAllauthorizerConfiguration,\n}"` | config https://github.com/buildbarn/bb-storage/blob/e5ee29d82ea7f458ad720a6ade4480e5838ab495/pkg/proto/configuration/bb_storage/bb_storage.proto |
| frontend.containerGrpcPort | int | `8980` | grpc port exposed by container |
| frontend.containerHttpPort | int | `80` | http port exposed by container |
| frontend.enabled | bool | `true` | enable frontend component |
| frontend.env | list | `[]` | environment variables for the deployment |
| frontend.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| frontend.livenessProbe.httpGet.path | string | `"/-/healthy"` | path for liveness probe |
| frontend.livenessProbe.httpGet.port | string | `"http-metrics"` | port for liveness probe |
| frontend.nodeSelector | object | `{}` | node for scheduler pod assignment |
| frontend.podMonitor.additionalLabels | object | `{}` | additional labels for pod monitor |
| frontend.podMonitor.enabled | bool | `false` | PodMonitor CRD is created for a prometheus operator |
| frontend.podSecurityContext | object | `{}` | specifies security settings for a pod |
| frontend.readinessProbe.httpGet.path | string | `"/-/healthy"` | path for readiness probe |
| frontend.readinessProbe.httpGet.port | string | `"http-metrics"` | port for readiness probe |
| frontend.replicaCount | int | `1` | number of replicas for the deployment. |
| frontend.resources | object | `{}` | custom resource configuration |
| frontend.securityContext | object | `{}` | specifies security settings for a container |
| frontend.service.grpc.name | string | `"grpc"` | grpc service name |
| frontend.service.grpc.port | int | `8980` | grpc service port |
| frontend.service.type | string | `"ClusterIP"` | service type |
| frontend.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| frontend.volumeMounts | list | `[]` | volume mounts |
| frontend.volumes | list | `[]` | volumes |
| fullnameOverride | string | `""` | full name of the chart. |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| nameOverride | string | `""` | override name of the chart |
| scheduler.affinity | object | `{}` | affinity for scheduler pod assignment |
| scheduler.conf | string | `"local common = import 'common.libsonnet';\n{\n  global: common.global,\n  admin_http_listen_address: ':80',\n  execute_authorizer: common.allowAllauthorizerConfiguration,\n  clientGrpcServers: [{\n    listenAddresses: [':8982'],\n    authenticationPolicy: { allow: {} },\n  }],\n  workerGrpcServers: [{\n    listenAddresses: [':8983'],\n    authenticationPolicy: { allow: {} },\n  }],\n  contentAddressableStorage: common.blobstore.contentAddressableStorage,\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n  browserUrl: common.browserUrl,\n  action_router: {\n    simple: {\n      platformKeyExtractor: { actionAndCommand: {} },\n      invocationKeyExtractors: [{ toolInvocationId: {} }],\n      initialSizeClassAnalyzer: {\n        defaultExecutionTimeout: '1800s',\n        maximumExecutionTimeout: '7200s',\n      },\n    },\n  },\n  platformQueueWithNoWorkersTimeout: '900s', \n}"` | config https://github.com/buildbarn/bb-remote-execution/blob/74b54e3e72c8ae507bbee1efe18aad1fbbe8de9e/pkg/proto/configuration/bb_scheduler/bb_scheduler.proto |
| scheduler.containerGrpcClientPort | int | `8982` | client grpc port exposed by container |
| scheduler.containerGrpcWorkerPort | int | `8983` | worker grpc port exposed by container |
| scheduler.containerHttpPort | int | `80` | http port exposed by container |
| scheduler.enabled | bool | `true` | enable scheduler component |
| scheduler.env | list | `[]` | environment variables for the deployment |
| scheduler.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| scheduler.image.repository | string | `"buildbarn/bb-scheduler"` | image repository |
| scheduler.image.tag | string | `"20220211T141613Z-74b54e3"` | image tag |
| scheduler.livenessProbe.httpGet.path | string | `"/-/healthy"` | path for liveness probe |
| scheduler.livenessProbe.httpGet.port | string | `"http-metrics"` | port for liveness probe |
| scheduler.nodeSelector | object | `{}` | node for scheduler pod assignment |
| scheduler.podMonitor.additionalLabels | object | `{}` | additional labels for pod monitor |
| scheduler.podMonitor.enabled | bool | `false` | PodMonitor CRD is created for a prometheus operator |
| scheduler.podSecurityContext | object | `{}` | specifies security settings for a pod |
| scheduler.readinessProbe.httpGet.path | string | `"/-/healthy"` | path for readiness probe |
| scheduler.readinessProbe.httpGet.port | string | `"http-metrics"` | port for readiness probe |
| scheduler.replicaCount | int | `1` | number of replicas for the deployment. |
| scheduler.resources | object | `{}` | custom resource configuration |
| scheduler.securityContext | object | `{}` | specifies security settings for a container |
| scheduler.service.grpcClient.name | string | `"grpc-client"` | grpc client service name |
| scheduler.service.grpcClient.port | int | `8982` | grpc client service port |
| scheduler.service.grpcWorker.name | string | `"grpc-worker"` | grpc worker service name |
| scheduler.service.grpcWorker.port | int | `8983` | grpc worker service port |
| scheduler.service.http.name | string | `"http"` | http service name |
| scheduler.service.http.port | int | `80` | http service port |
| scheduler.service.type | string | `"ClusterIP"` | service type |
| scheduler.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| scheduler.volumeMounts | list | `[]` | volume mounts |
| scheduler.volumes | list | `[]` | volumes |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| storage.affinity | object | `{}` | affinity for scheduler pod assignment |
| storage.conf | string | `"local common = import 'common.libsonnet';\n{\n  global: common.global,\n  blobstore: {\n    contentAddressableStorage: {\n      'local': {\n        keyLocationMapOnBlockDevice: {\n          file: {\n            path: '/cas/key_location_map',\n            sizeBytes: 16 * 1024 * 1024,\n          },\n        },\n        keyLocationMapMaximumGetAttempts: 8,\n        keyLocationMapMaximumPutAttempts: 32,\n        oldBlocks: 8,\n        currentBlocks: 24,\n        newBlocks: 3,\n        blocksOnBlockDevice: {\n          source: {\n            file: {\n              path: '/cas/blocks',\n              sizeBytes: 10 * 1024 * 1024 * 1024,\n            },\n          },\n          spareBlocks: 3,\n        },\n        persistent: {\n          stateDirectoryPath: '/cas',\n          minimumEpochInterval: '300s',\n        },\n      },\n    },\n    actionCache: {\n      completenessChecking: {\n        'local': {\n          keyLocationMapOnBlockDevice: {\n            file: {\n              path: '/ac/key_location_map',\n              sizeBytes: 1024 * 1024,\n            },\n          },\n          keyLocationMapMaximumGetAttempts: 8,\n          keyLocationMapMaximumPutAttempts: 32,\n          oldBlocks: 8,\n          currentBlocks: 24,\n          newBlocks: 1,\n          blocksOnBlockDevice: {\n            source: {\n              file: {\n                path: '/ac/blocks',\n                sizeBytes: 100 * 1024 * 1024,\n              },\n            },\n            spareBlocks: 3,\n          },\n          persistent: {\n            stateDirectoryPath: '/ac',\n            minimumEpochInterval: '300s',\n          },\n        },\n      },\n    },\n  },\n  grpcServers: [{\n    listenAddresses: [':8981'],\n    authenticationPolicy: common.allowAllauthorizerConfiguration,\n  }],\n  contentAddressableStorageAuthorizers: {\n    get: common.allowAllauthorizerConfiguration,\n    put: common.allowAllauthorizerConfiguration,\n    findMissing: common.allowAllauthorizerConfiguration,\n  },\n  actionCacheAuthorizers: {\n    get: common.allowAllauthorizerConfiguration,\n    put: common.allowAllauthorizerConfiguration,\n  },\n  executeAuthorizer: common.allowAllauthorizerConfiguration,\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n}"` | config https://github.com/buildbarn/bb-storage/blob/e5ee29d82ea7f458ad720a6ade4480e5838ab495/pkg/proto/configuration/bb_storage/bb_storage.proto |
| storage.containerGrpcPort | int | `8981` | grpc port exposed by container |
| storage.enabled | bool | `true` | enable storage component |
| storage.env | list | `[]` | environment variables for the deployment |
| storage.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| storage.image.repository | string | `"buildbarn/bb-storage"` | image repository |
| storage.image.tag | string | `"20220211T114844Z-e5ee29d"` | image tag |
| storage.livenessProbe.httpGet.path | string | `"/-/healthy"` | path for liveness probe |
| storage.livenessProbe.httpGet.port | string | `"http-metrics"` | port for liveness probe |
| storage.nodeSelector | object | `{}` | node for scheduler pod assignment |
| storage.podMonitor.additionalLabels | object | `{}` | additional labels for pod monitor |
| storage.podMonitor.enabled | bool | `false` | PodMonitor CRD is created for a prometheus operator |
| storage.podSecurityContext | object | `{}` | specifies security settings for a pod |
| storage.readinessProbe.httpGet.path | string | `"/-/healthy"` | path for readiness probe |
| storage.readinessProbe.httpGet.port | string | `"http-metrics"` | port for readiness probe |
| storage.replicaCount | int | `2` | number of replicas for the deployment. |
| storage.resources | object | `{}` | custom resource configuration |
| storage.securityContext | object | `{}` | specifies security settings for a container |
| storage.service.grpc.name | string | `"grpc"` | grpc service name |
| storage.service.grpc.port | int | `8981` | grpc service port |
| storage.service.type | string | `"ClusterIP"` | service type |
| storage.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| storage.volumeClaims.ac | object | `{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"1Gi"}}}` | ac volume claim spec |
| storage.volumeClaims.additional | list | `[]` | additional volume claims |
| storage.volumeClaims.cas | object | `{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"12Gi"}}}` | cas volume claim spec |
| storage.volumeMounts | list | `[]` | volume mounts |
| storage.volumes | list | `[]` | volumes |
| worker.affinity | object | `{}` | affinity for scheduler pod assignment |
| worker.enabled | bool | `true` | enable worker component |
| worker.env | list | `[]` | environment variables for the deployment |
| worker.nodeSelector | object | `{}` | node for scheduler pod assignment |
| worker.podMonitor.additionalLabels | object | `{}` | additional labels for pod monitor |
| worker.podMonitor.enabled | bool | `false` | PodMonitor CRD is created for a prometheus operator |
| worker.podSecurityContext | object | `{}` | specifies security settings for a pod |
| worker.replicaCount | int | `1` | number of replicas for the deployment. |
| worker.runnerConf | string | `"{\n  buildDirectoryPath: '/worker/build',\n  set_tmpdir_environment_variable: true,\n  grpcServers: [{\n    listenPaths: ['/worker/runner'],\n    authenticationPolicy: { allow: {} },\n  }],\n}"` | config https://github.com/buildbarn/bb-remote-execution/blob/74b54e3e72c8ae507bbee1efe18aad1fbbe8de9e/pkg/proto/configuration/bb_runner/bb_runner.proto |
| worker.runnerContainer.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| worker.runnerContainer.image.repository | string | `"l.gcr.io/google/rbe-ubuntu18-04"` | image repository (default is https://console.cloud.google.com/marketplace/product/google/rbe-ubuntu18-04) |
| worker.runnerContainer.image.tag | string | `"latest@sha256:48b67b41118dbcdfc265e7335f454fbefa62681ab8d47200971fc7a52fb32054"` | image tag |
| worker.runnerContainer.resources | object | `{}` | custom resource configuration |
| worker.runnerContainer.securityContext | object | `{"allowPrivilegeEscalation":false,"runAsUser":65534}` | specifies security settings for a container |
| worker.runnerInstallerContainer.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| worker.runnerInstallerContainer.image.repository | string | `"buildbarn/bb-runner-installer"` | image repository |
| worker.runnerInstallerContainer.image.tag | string | `"20220211T141613Z-74b54e3"` | image tag |
| worker.tolerations | list | `[]` | tolerations for scheduler pod assignment |
| worker.volumeInitContainer.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| worker.volumeInitContainer.image.repository | string | `"busybox"` | image repository |
| worker.volumeInitContainer.image.tag | string | `"1.31.1-uclibc"` | image tag |
| worker.volumeMounts | list | `[]` | volume mounts |
| worker.volumes | list | `[]` | volumes |
| worker.workerConf | string | `"local common = import 'common.libsonnet';\n{\n  global: common.global,\n  blobstore: common.blobstore,\n  maximumMessageSizeBytes: common.maximumMessageSizeBytes,\n  scheduler: { address: 'buildbarn-scheduler:8983' },\n  maximumMemoryCachedDirectories: 1000,\n  browserUrl: common.browserUrl,\n  buildDirectories: [{\n    native: {\n      buildDirectoryPath: '/worker/build',\n      cacheDirectoryPath: '/worker/cache',\n      maximumCacheFileCount: 10000,\n      maximumCacheSizeBytes: 1024 * 1024 * 1024,\n      cacheReplacementPolicy: 'RANDOM_REPLACEMENT',\n    },\n    runners: [{\n      endpoint: { address: 'unix:///worker/runner' },\n      instanceNamePrefix: 'remote-execution',\n      concurrency: 8,\n      platform: {\n        properties: [\n          { name: 'OSFamily', value: 'Linux' },\n          { name: 'container-image', value: 'docker://marketplace.gcr.io/google/rbe-ubuntu18-04@sha256:48b67b41118dbcdfc265e7335f454fbefa62681ab8d47200971fc7a52fb32054' },\n        ],\n      },\n      workerId: {\n        'pod': std.extVar(\"POD_NAME\"),\n        'node': std.extVar(\"NODE_NAME\")\n      },\n    }],\n  }],\n}"` | config https://github.com/buildbarn/bb-remote-execution/blob/74b54e3e72c8ae507bbee1efe18aad1fbbe8de9e/pkg/proto/configuration/bb_worker/bb_worker.proto |
| worker.workerContainer.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| worker.workerContainer.image.repository | string | `"buildbarn/bb-worker"` | image repository |
| worker.workerContainer.image.tag | string | `"20220211T141613Z-74b54e3"` | image tag |
| worker.workerContainer.livenessProbe.httpGet.path | string | `"/-/healthy"` | path for liveness probe |
| worker.workerContainer.livenessProbe.httpGet.port | string | `"http-metrics"` | port for liveness probe |
| worker.workerContainer.readinessProbe.httpGet.path | string | `"/-/healthy"` | path for readiness probe |
| worker.workerContainer.readinessProbe.httpGet.port | string | `"http-metrics"` | port for readiness probe |
| worker.workerContainer.resources | object | `{}` | custom resource configuration |
| worker.workerContainer.securityContext | object | `{}` | specifies security settings for a container |
