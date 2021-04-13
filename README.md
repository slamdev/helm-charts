# Helm Charts

This repository contains [Helm](https://helm.sh) charts for various projects

* [Altinity Clickhouse Operator](https://github.com/slamdev/helm-charts/tree/master/charts/altinity-clickhouse-operator)
* [Archiva](https://github.com/slamdev/helm-charts/tree/master/charts/archiva)
* [Docker Registry Proxy](https://github.com/slamdev/helm-charts/tree/master/charts/docker-registry-proxy)
* [Envoy](https://github.com/slamdev/helm-charts/tree/master/charts/envoy)
* [External Secrets Operator](https://github.com/slamdev/helm-charts/tree/master/charts/external-secrets-operator)
* [FluentD](https://github.com/slamdev/helm-charts/tree/master/charts/fluentd)
* [Flux Notifier](https://github.com/slamdev/helm-charts/tree/master/charts/flux-notifier)
* [Gitlab Omnibus](https://github.com/slamdev/helm-charts/tree/master/charts/gitlab-omnibus)
* [GKE Preemptible Notifier](https://github.com/slamdev/helm-charts/tree/master/charts/gke-preemptible-notifier)
* [Gradle Cache](https://github.com/slamdev/helm-charts/tree/master/charts/gradle-cache)
* [HAProxy](https://github.com/slamdev/helm-charts/tree/master/charts/haproxy)
* [Kube Resource Report](https://github.com/slamdev/helm-charts/tree/master/charts/kube-resource-report)
* [Nginx](https://github.com/slamdev/helm-charts/tree/master/charts/nginx)
* [Octavia Ingress Controller](https://github.com/slamdev/helm-charts/tree/master/charts/octavia-ingress-controller)
* [Pgweb](https://github.com/slamdev/helm-charts/tree/master/charts/pgweb)
* [Weblate](https://github.com/slamdev/helm-charts/tree/master/charts/weblate)
* [Zeppelin](https://github.com/slamdev/helm-charts/tree/master/charts/zeppelin)

## Installing Charts from this Repository

Add the Repository to Helm:
```sh
$ helm repo add slamdev-helm-charts https://slamdev.github.io/helm-charts
```

Install a chart:
```sh
$ helm install slamdev-helm-charts/[CHART_NAME]
```
