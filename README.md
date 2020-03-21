# Helm Charts

This repository contains [Helm](https://helm.sh) charts for various projects

* [External Secrets Operator](https://github.com/slamdev/helm-charts/tree/master/charts/external-secrets-operator)
* [Nginx](https://github.com/slamdev/helm-charts/tree/master/charts/nginx)

## Installing Charts from this Repository

Add the Repository to Helm:
```sh
$ helm repo add slamdev-helm-charts https://slamdev.github.io/helm-charts
```

Install a chart:
```sh
$ helm install slamdev-helm-charts/[CHART_NAME]
```
