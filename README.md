# Helm Charts

This repository contains [Helm](https://helm.sh) charts for various projects

* [Archiva](https://github.com/slamdev/helm-charts/tree/master/charts/archiva)
* [External Secrets Operator](https://github.com/slamdev/helm-charts/tree/master/charts/external-secrets-operator)
* [FluentD](https://github.com/slamdev/helm-charts/tree/master/charts/fluentd)
* [Flux Notifier](https://github.com/slamdev/helm-charts/tree/master/charts/flux-notifier)
* [Gitlab Omnibus](https://github.com/slamdev/helm-charts/tree/master/charts/gitlab-omnibus)
* [GKE Preemptible Notifier](https://github.com/slamdev/helm-charts/tree/master/charts/gke-preemptible-notifier)
* [Gradle Cache](https://github.com/slamdev/helm-charts/tree/master/charts/gradle-cache)
* [HAProxy](https://github.com/slamdev/helm-charts/tree/master/charts/haproxy)
* [Nginx](https://github.com/slamdev/helm-charts/tree/master/charts/nginx)
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
