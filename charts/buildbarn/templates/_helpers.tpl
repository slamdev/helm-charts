{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "buildbarn.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "buildbarn.fullname" -}}
{{- $ := index . 0 -}}
{{- $component := index . 1 -}}
{{- if $.Values.fullnameOverride -}}
{{- printf "%s-%s" $.Values.fullnameOverride $component | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default $.Chart.Name $.Values.nameOverride -}}
{{- if contains $name $.Release.Name -}}
{{- printf "%s-%s" $.Release.Name $component | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" $.Release.Name $name $component | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "buildbarn.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "buildbarn.labels" -}}
{{- $ := index . 0 -}}
helm.sh/chart: {{ include "buildbarn.chart" $ }}
{{ include "buildbarn.selectorLabels" . }}
{{- if $.Chart.AppVersion }}
app.kubernetes.io/version: {{ $.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ $.Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "buildbarn.selectorLabels" -}}
{{- $ := index . 0 -}}
{{- $component := index . 1 -}}
app.kubernetes.io/name: {{ include "buildbarn.name" $ }}
app.kubernetes.io/instance: {{ $.Release.Name }}
app.kubernetes.io/component: {{ $component }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "buildbarn.serviceAccountName" -}}
{{- $ := index . 0 -}}
{{- if $.Values.serviceAccount.create -}}
    {{ default (include "buildbarn.fullname" .) $.Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" $.Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
