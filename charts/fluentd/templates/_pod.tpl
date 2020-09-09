{{- define "fluentd.pod" -}}
metadata:
  labels:
    {{- include "fluentd.selectorLabels" . | nindent 4 }}
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
  serviceAccountName: {{ include "fluentd.serviceAccountName" . }}
  securityContext:
    {{- toYaml .Values.podSecurityContext | nindent 4 }}
  containers:
    - name: {{ .Chart.Name }}
      securityContext:
        {{- toYaml .Values.securityContext | nindent 8 }}
      image: "{{ .Values.image.repository }}:{{ include "fluentd.tag" . }}"
      command:
        - tini
        - --
        - /opt/entrypoint.sh
      imagePullPolicy: {{ .Values.image.pullPolicy }}
    {{- with .Values.containerPorts }}
      ports:
        {{- toYaml . | nindent 8 }}
    {{- end }}
      livenessProbe:
        {{- toYaml .Values.livenessProbe | nindent 8 }}
      readinessProbe:
        {{- toYaml .Values.readinessProbe | nindent 8 }}
      resources:
        {{- toYaml .Values.resources | nindent 8 }}
      env:
        - name: FLUENTD_CONF
          value: custom/fluent.conf
    {{- with .Values.env }}
      {{- toYaml . | nindent 8 }}
    {{- end }}
      volumeMounts:
        - name: {{ include "fluentd.fullname" . }}
          mountPath: /fluentd/etc/custom/fluent.conf
          subPath: fluent.conf
        - name: {{ include "fluentd.fullname" . }}
          mountPath: /opt/entrypoint.sh
          subPath: entrypoint.sh
    {{- with .Values.volumeMounts }}
        {{- toYaml . | nindent 8 }}
    {{- end }}
  volumes:
    - name: {{ include "fluentd.fullname" . }}
      configMap:
        name: {{ include "fluentd.fullname" . }}
        defaultMode: 0777
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
