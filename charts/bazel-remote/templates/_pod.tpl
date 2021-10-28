{{- define "bazel-remote.pod" -}}
metadata:
  labels:
    {{- include "bazel-remote.selectorLabels" . | nindent 4 }}
  annotations:
    checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
  {{- with .Values.podAnnotations }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
{{- with .Values.imagePullSecrets }}
  imagePullSecrets:
    {{- toYaml . | nindent 4 }}
{{- end }}
  serviceAccountName: {{ include "bazel-remote.serviceAccountName" . }}
  securityContext:
    {{- toYaml .Values.podSecurityContext | nindent 4 }}
  containers:
    - name: {{ .Chart.Name }}
      securityContext:
        {{- toYaml .Values.securityContext | nindent 8 }}
      image: "{{ .Values.image.repository }}:{{ include "bazel-remote.tag" . }}"
      imagePullPolicy: {{ .Values.image.pullPolicy }}
    {{- with .Values.containerPorts }}
      ports:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      livenessProbe:
        {{- toYaml .Values.livenessProbe | nindent 8 }}
      readinessProbe:
        {{- toYaml .Values.readinessProbe | nindent 8 }}
      startupProbe:
        {{- toYaml .Values.readinessProbe | nindent 8 }}
      resources:
        {{- toYaml .Values.resources | nindent 8 }}
      env:
        - name: BAZEL_REMOTE_CONFIG_FILE
          value: /bazel-remote.yaml
    {{- with .Values.env }}
      {{- toYaml . | nindent 8 }}
    {{- end }}
      volumeMounts:
        - name: {{ include "bazel-remote.fullname" . }}
          mountPath: /bazel-remote.yaml
          subPath: bazel-remote.yaml
    {{- with .Values.volumeMounts }}
        {{- toYaml . | nindent 8 }}
    {{- end }}
  volumes:
    - name: {{ include "bazel-remote.fullname" . }}
      configMap:
        name: {{ include "bazel-remote.fullname" . }}
        defaultMode: 0644
{{- with .Values.volumes }}
    {{- toYaml . | nindent 4 }}
{{- end }}
{{- with .Values.nodeSelector }}
  nodeSelector:
    {{- toYaml . | nindent 4 }}
{{- end }}
{{- with .Values.affinity }}
  affinity:
    {{- toYaml . | nindent 4 }}
{{- end }}
{{- with .Values.tolerations }}
  tolerations:
    {{- toYaml . | nindent 4 }}
{{- end }}

{{- end -}}
