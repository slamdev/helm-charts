{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "gradle-cache.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gradle-cache.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gradle-cache.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "gradle-cache.labels" -}}
helm.sh/chart: {{ include "gradle-cache.chart" . }}
{{ include "gradle-cache.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "gradle-cache.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gradle-cache.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "gradle-cache.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "gradle-cache.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the config secret to use
*/}}
{{- define "gradle-cache.configSecretName" -}}
{{- if .Values.configSecret.create -}}
    {{ default (include "gradle-cache.fullname" .) .Values.configSecret.name }}
{{- else -}}
    {{ default "default" .Values.configSecret.name }}
{{- end -}}
{{- end -}}

{{/*
Create the tag for the docker image to use
*/}}
{{- define "gradle-cache.tag" -}}
{{- .Values.image.tag | default .Chart.AppVersion -}}
{{- end -}}
