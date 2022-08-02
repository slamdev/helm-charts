# gitlab-omnibus

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 15.2.1-ee.0](https://img.shields.io/badge/AppVersion-15.2.1--ee.0-informational?style=flat-square)

Helm chart to deploy [Omnibus Gitlab](https://docs.gitlab.com/omnibus/).

**Homepage:** <https://github.com/slamdev/helm-charts/tree/master/charts/gitlab-omnibus>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| slamdev | <valentin.fedoskin@gmail.com> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalResources | list | `[]` | list of additional resources to create (are processed via `tpl` function) |
| affinity | object | `{}` | affinity for scheduler pod assignment |
| backupCronJob.command | list | `["gitlab-backup","create","SKIP=uploads,builds,artifacts,terraform_state,registry,pages,packages","GZIP_RSYNCABLE=yes","STRATEGY=copy"]` | command to execute in gitlab container |
| backupCronJob.enabled | bool | `true` | enable scheduled backups |
| backupCronJob.image | string | `"daedalusproject/base_kubectl"` | image |
| backupCronJob.resources | object | `{"requests":{"cpu":"10m","memory":"32Mi"}}` | custom resource configuration |
| backupCronJob.schedule | string | `"@daily"` | how often to run backaup job |
| containerPorts | list | `[{"containerPort":8005,"name":"http"},{"containerPort":22,"name":"ssh"}]` | ports exposed by the container |
| env | list | `[]` | environment variables for the container |
| envFrom | list | `[]` | environment variable sources for the container |
| fullnameOverride | string | `""` | full name of the chart. |
| gitlabConf | string | `"external_url 'https://gitlab.example.com'\ngitlab_rails['gitlab_repository_downloads_path'] = '/opt/tmp/repositories'\ngitlab_rails['object_store']['enabled'] = true\ngitlab_rails['object_store']['connection'] = {\n  'provider' => 'AWS',\n  'aws_access_key_id' => 'XXX',\n  'aws_secret_access_key' => 'XXX',\n}\ngitlab_rails['object_store']['objects']['artifacts']['bucket'] = 'gitlab/artifacts'\ngitlab_rails['object_store']['objects']['external_diffs']['bucket'] = 'gitlab/external_diffs'\ngitlab_rails['object_store']['objects']['lfs']['bucket'] = 'gitlab/lfs'\ngitlab_rails['object_store']['objects']['uploads']['bucket'] = 'gitlab/uploads'\ngitlab_rails['object_store']['objects']['packages']['bucket'] = 'gitlab/packages'\ngitlab_rails['object_store']['objects']['dependency_proxy']['bucket'] = 'gitlab/dependency_proxy'\ngitlab_rails['object_store']['objects']['terraform_state']['bucket'] = 'gitlab/terraform_state'\ngitlab_rails['object_store']['objects']['ci_secure_files']['bucket'] = 'gitlab/ci_secure_files'\ngitlab_rails['external_diffs_enabled'] = true\ngitlab_rails['external_diffs_when'] = 'outdated'\ngitlab_rails['shared_path'] = '/opt/tmp/shared'\ngitlab_rails['backup_path'] = \"/opt/tmp/backups\"\ngitlab_rails['backup_upload_connection'] = {\n  'provider' => 'AWS',\n  'aws_access_key_id' => 'XXX',\n  'aws_secret_access_key' => 'XXX',\n}\ngitlab_rails['backup_upload_remote_directory'] = 'gitlab/backups'\ngitlab_rails['uploads_directory'] = \"/opt/tmp/uploads\"\ngitlab_rails['initial_root_password'] = ENV['GITLAB_INITIAL_ROOT_PASSWORD']\ngitlab_rails['initial_shared_runners_registration_token'] = ENV['GITLAB_RUNNER_TOKEN']\ngitlab_rails['db_adapter'] = \"postgresql\"\ngitlab_rails['db_database'] = \"gitlab\"\ngitlab_rails['db_username'] = ENV['PG_USER']\ngitlab_rails['db_password'] = ENV['PG_PASSWORD']\ngitlab_rails['db_host'] = \"gitlab-postgres\"\ngitlab_rails['db_port'] = 5432\ngitlab_rails['redis_host'] = \"gitlab-redis-master\"\ngitlab_rails['redis_port'] = 6379\ngitlab_rails['registry_enabled'] = false\nregistry['enable'] = false\ngitlab_workhorse['listen_network'] = \"tcp\"\ngitlab_workhorse['listen_addr'] = \"0.0.0.0:8005\"\nsidekiq['metrics_enabled'] = false\nsidekiq['health_checks_enabled'] = false\npostgresql['enable'] = false\nredis['enable'] = false\nnginx['enable'] = false\npages_nginx['enable'] = false\ngitlab_ci['builds_directory'] = '/opt/tmp/ci-builds'\ngitlab_rails['gitlab_kas_enabled'] = false\ngitlab_kas['enable'] = false\nmonitoring_role['enable'] = false\nprometheus['enable'] = false\nprometheus_monitoring['enable'] = false\nalertmanager['enable'] = false\ngrafana['enable'] = false\ngitlab_exporter['enable'] = false\ngitlab_rails['packages_enabled'] = false\ngitlab_rails['dependency_proxy_enabled'] = false"` | config for gitlab.rb; default values: https://gitlab.com/gitlab-org/omnibus-gitlab/-/blob/15.2.1+ce.0/files/gitlab-config-template/gitlab.rb.template |
| healthCheckToken | string | `"CHANGE_ME"` | predefined health check token for status probes; should be changed to a random value |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"gitlab/gitlab-ee"` | image repository |
| image.tag | string | `""` | image tag (chart's appVersion value will be used if not set) |
| imagePullSecrets | list | `[]` | image pull secret for private images |
| nameOverride | string | `""` | override name of the chart |
| nodeSelector | object | `{}` | node for scheduler pod assignment |
| podSecurityContext | object | `{}` | specifies security settings for a pod |
| resources | object | `{}` | custom resource configuration |
| securityContext | object | `{}` | specifies security settings for a container |
| service.annotations | object | `{}` | service annotations |
| service.loadBalancerIP | string | `nil` | load balancer IP |
| service.ports | list | `[{"name":"http","port":80,"targetPort":"http"},{"name":"ssh","port":22,"targetPort":"ssh"}]` | service ports |
| service.type | string | `"ClusterIP"` | service type |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `false` | specifies whether a service account should be created |
| serviceAccount.name | string | `nil` | the name of the service account to use; if not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | tolerations for scheduler pod assignment |
| volumeClaimTemplates | list | `[]` | volume claim templates |
| volumeMounts | list | `[]` | additional volume mounts |
| volumes | list | `[]` | volumes |
