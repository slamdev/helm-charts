{{- define "grafana-agent.pod" -}}
metadata:
  labels:
    {{- include "grafana-agent.selectorLabels" . | nindent 4 }}
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
  serviceAccountName: {{ include "grafana-agent.serviceAccountName" . }}
  securityContext:
    {{- toYaml .Values.podSecurityContext | nindent 4 }}
  containers:
    - name: {{ .Chart.Name }}
    {{- with .Values.args }}
      args:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      securityContext:
        {{- toYaml .Values.securityContext | nindent 8 }}
      image: "{{ .Values.image.repository }}:{{ include "grafana-agent.tag" . }}"
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
        {{- toYaml .Values.startupProbe | nindent 8 }}
      resources:
        {{- toYaml .Values.resources | nindent 8 }}
    {{- with .Values.env }}
      env:
      {{- toYaml . | nindent 8 }}
    {{- end }}
      volumeMounts:
        - name: {{ include "grafana-agent.fullname" . }}
          mountPath: /grafana-agent.yaml
          subPath: grafana-agent.yaml
    {{- with .Values.volumeMounts }}
        {{- toYaml . | nindent 8 }}
    {{- end }}
  volumes:
    - name: {{ include "grafana-agent.fullname" . }}
      configMap:
        name: {{ include "grafana-agent.fullname" . }}
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
