#!/usr/bin/env bash

#
# Script downloads manifest from altinity repo, splits it to separate files
#  and puts to the corresponding folders
# NOTE: yq ( https://mikefarah.gitbook.io/yq/ ) > v4.14.x, jq and perl are required
#
# Usage: ./sync-yamls.sh
#

set -o errexit
set -o nounset
set -o pipefail

readonly repo_url="https://raw.githubusercontent.com/Altinity/clickhouse-operator"
readonly crds_dir="../crds"
readonly templates_dir="../templates/generated"
readonly manifest_path="deploy/operator/clickhouse-operator-install-bundle.yaml"
readonly values_yaml="../values.yaml"
readonly chart_def="../Chart.yaml"
readonly files_dir="../files"
readonly dashboards_path="grafana-dashboard"
readonly dashboards=("Altinity_ClickHouse_Operator_dashboard.json" "ClickHouseKeeper_dashboard.json" "ClickHouse_Queries_dashboard.json" "Zookeeper_dashboard.json")

function main() {
  readonly detected_version=$(detect_version)
  readonly manifest_url="${repo_url}/${detected_version}/${manifest_path}"
  local tmpdir
  tmpdir=$(mktemp -d)

  # shellcheck disable=SC2016
  (cd "${tmpdir}" && curl -s "${manifest_url}" 2>&1 | yq e --no-doc -s '$index')

  for f in "${tmpdir}"/*.yml; do
    process "${f}"
  done

  readonly prom_ds='{"current":{"selected":false,"text":"","value":""},"hide":0,"includeAll":false,"multi":false,"name":"ds_prometheus","options":[],"query":"prometheus","queryValue":"","refresh":1,"regex":"","skipUrlSync":false,"type":"datasource"}'

  mkdir -p "${files_dir}"
  for dashboard in "${dashboards[@]}"; do
    local dashboard_url="${repo_url}/${detected_version}/${dashboards_path}/${dashboard}"
    curl -s "${dashboard_url}" | jq '(.templating.list) |= ['"${prom_ds}"'] + .' >"${files_dir}/${dashboard}"
    perl -pi -e 's/"datasource": "\${DS_PROMETHEUS}"/"datasource": {"type":"prometheus","uid":"\${ds_prometheus}"}/g' "${files_dir}/${dashboard}"
    perl -pi -e 's/"datasource": "\$db"/"datasource": {"type":"vertamedia-clickhouse-datasource","uid":"\${db}"}/g' "${files_dir}/${dashboard}"
  done
}

function process() {
  local file="${1}"
  local kind
  kind=$(yq e '.kind' "${file}")
  local name
  name=$(yq e '.metadata.name' "${file}")

  local processed_file="${kind}-${name}.yaml"
  if [[ "${kind}" == "CustomResourceDefinition" ]]; then
    processed_file="${crds_dir}/${processed_file}"
  else
    processed_file="${templates_dir}/${processed_file}"
  fi
  mkdir -p "$(dirname "${processed_file}")"
  mv "${file}" "${processed_file}"

  case ${kind} in
  Service)
    update_service_resource "${processed_file}"
    ;;
  Deployment)
    update_deployment_resource "${processed_file}"
    ;;
  ConfigMap)
    update_configmap_resource "${processed_file}"
    ;;
  ClusterRoleBinding)
    update_clusterrolebinding_resource "${processed_file}"
    ;;
  ClusterRole)
    update_clusterrole_resource "${processed_file}"
    ;;
  ServiceAccount)
    update_serviceaccount_resource "${processed_file}"
    ;;
  Secret)
    update_secret_resource "${processed_file}"
    ;;
  CustomResourceDefinition) ;;

  *)
    echo "do not know how to process ${kind}"
    exit 1
    ;;
  esac
}

function update_service_resource() {
  readonly file="${1}"
  readonly name=$(yq e '.metadata.name' "${file}")

  if [ "${name}" != 'clickhouse-operator-metrics' ]; then
    echo "do not know how to process ${name} service"
    exit 1
  fi

  yq e -i '.metadata.name |= "{{ printf \"%s-metrics\" (include \"altinity-clickhouse-operator.fullname\" .) }}"' "${file}"
  yq e -i '.metadata.namespace |= "{{ .Release.Namespace }}"' "${file}"
  yq e -i '.metadata.labels |= "{{ include \"altinity-clickhouse-operator.labels\" . | nindent 4 }}"' "${file}"
  yq e -i '.spec.selector |= "{{ include \"altinity-clickhouse-operator.selectorLabels\" . | nindent 4 }}"' "${file}"

  perl -pi -e "s/'//g" "${file}"
}

function update_deployment_resource() {
  readonly file="${1}"
  readonly name=$(yq e '.metadata.name' "${file}")

  if [ "${name}" != 'clickhouse-operator' ]; then
    echo "do not know how to process ${name} deployment"
    exit 1
  fi

  yq e -i '.metadata.name |= "{{ include \"altinity-clickhouse-operator.fullname\" . }}"' "${file}"
  yq e -i '.metadata.namespace |= "{{ .Release.Namespace }}"' "${file}"
  yq e -i '.metadata.labels |= "{{ include \"altinity-clickhouse-operator.labels\" . | nindent 4 }}"' "${file}"
  yq e -i '.spec.selector.matchLabels |= "{{ include \"altinity-clickhouse-operator.selectorLabels\" . | nindent 6 }}"' "${file}"

  readonly annotations=$(yq e '.spec.template.metadata.annotations' "${file}")
  a_data="${annotations}" yq e -i '.podAnnotations |= env(a_data)' "${values_yaml}"
  yq e -i '.spec.template.metadata.annotations = {}' "${file}"

  yq e -i '.spec.template.metadata.labels |= "{{ include \"altinity-clickhouse-operator.selectorLabels\" . | nindent 8 }}"' "${file}"
  yq e -i '.spec.template.metadata.annotations += {"{{ toYaml .Values.podAnnotations | nindent 8 }}": null}' "${file}"
  yq e -i '.spec.template.spec.imagePullSecrets |= "{{ toYaml .Values.imagePullSecrets | nindent 8 }}"' "${file}"
  yq e -i '.spec.template.spec.serviceAccountName |= "{{ include \"altinity-clickhouse-operator.serviceAccountName\" . }}"' "${file}"
  yq e -i '.spec.template.spec.nodeSelector |= "{{ toYaml .Values.nodeSelector | nindent 8 }}"' "${file}"
  yq e -i '.spec.template.spec.affinity |= "{{ toYaml .Values.affinity | nindent 8 }}"' "${file}"
  yq e -i '.spec.template.spec.tolerations |= "{{ toYaml .Values.tolerations | nindent 8 }}"' "${file}"

  for cm in $(yq e '.spec.template.spec.volumes[].configMap.name' "${file}"); do
    local prefix='{{ include \"altinity-clickhouse-operator.fullname\" . }}'
    local newCm="${cm/etc-clickhouse-operator/$prefix}"
    yq e -i '(.spec.template.spec.volumes[].configMap.name | select(. == "'"${cm}"'") | .) |= "'"${newCm}"'"' "${file}"
    local cmName="${cm/etc-clickhouse-operator-/}"
    yq e -i '.spec.template.metadata.annotations += {"checksum/'"${cmName}"'": "{{ include (print $.Template.BasePath \"/generated/ConfigMap-etc-clickhouse-operator-'"${cmName}"'.yaml\") . | sha256sum }}"}' "${file}"
  done

  yq e -i '.spec.template.spec.containers[0].name |= "{{ .Chart.Name }}"' "${file}"
  yq e -i '.spec.template.spec.containers[0].image |= "{{ .Values.operator.image.repository }}:{{ include \"altinity-clickhouse-operator.operator.tag\" . }}"' "${file}"
  yq e -i '.spec.template.spec.containers[0].imagePullPolicy |= "{{ .Values.operator.image.pullPolicy }}"' "${file}"
  yq e -i '.spec.template.spec.containers[0].resources |= "{{ toYaml .Values.operator.resources | nindent 12 }}"' "${file}"
  yq e -i '(.spec.template.spec.containers[0].env[] | select(.valueFrom.resourceFieldRef.containerName == "clickhouse-operator") | .valueFrom.resourceFieldRef.containerName) = "{{ .Chart.Name }}"' "${file}"
  yq e -i '.spec.template.spec.containers[0].env += ["{{ with .Values.operator.env }}{{ toYaml . | nindent 12 }}{{ end }}"]' "${file}"

  yq e -i '.spec.template.spec.containers[1].image |= "{{ .Values.metrics.image.repository }}:{{ include \"altinity-clickhouse-operator.metrics.tag\" . }}"' "${file}"
  yq e -i '.spec.template.spec.containers[1].imagePullPolicy |= "{{ .Values.metrics.image.pullPolicy }}"' "${file}"
  yq e -i '.spec.template.spec.containers[1].resources |= "{{ toYaml .Values.metrics.resources | nindent 12 }}"' "${file}"
  yq e -i '(.spec.template.spec.containers[1].env[] | select(.valueFrom.resourceFieldRef.containerName == "clickhouse-operator") | .valueFrom.resourceFieldRef.containerName) = "{{ .Chart.Name }}"' "${file}"
  yq e -i '.spec.template.spec.containers[1].env += ["{{ with .Values.metrics.env }}{{ toYaml . | nindent 12 }}{{ end }}"]' "${file}"

  perl -pi -e "s/'{{ toYaml .Values.podAnnotations \| nindent 8 }}': null/{{ toYaml .Values.podAnnotations \| nindent 8 }}/g" "${file}"
  perl -pi -e "s/- '{{ with .Values.operator.env }}{{ toYaml . \| nindent 12 }}{{ end }}'/{{ with .Values.operator.env }}{{ toYaml . \| nindent 12 }}{{ end }}/g" "${file}"
  perl -pi -e "s/- '{{ with .Values.metrics.env }}{{ toYaml . \| nindent 12 }}{{ end }}'/{{ with .Values.metrics.env }}{{ toYaml . \| nindent 12 }}{{ end }}/g" "${file}"

  perl -pi -e "s/'//g" "${file}"
}

function update_configmap_resource() {
  readonly file="${1}"
  readonly name=$(yq e '.metadata.name' "${file}")
  local data
  data=$(yq e '.data' "${file}")
  local name_suffix="${name/etc-clickhouse-operator-/}"
  local cameled_name
  cameled_name=$(to_camel_case "${name_suffix}")

  yq e -i '.metadata.name |= "{{ printf \"%s-'"${name_suffix}"'\" (include \"altinity-clickhouse-operator.fullname\" .) }}"' "${file}"
  yq e -i '.metadata.namespace |= "{{ .Release.Namespace }}"' "${file}"
  yq e -i '.metadata.labels |= "{{ include \"altinity-clickhouse-operator.labels\" . | nindent 4 }}"' "${file}"
  yq e -i '.data |= "{{ toYaml .Values.configs.'"${cameled_name}"' | nindent 2 }}"' "${file}"

  if [ -z "${data}" ]; then
    yq e -i '.configs.'"${cameled_name}"' |= null' "${values_yaml}"
  else
    data_arg="${data}" yq e -i '.configs.'"${cameled_name}"' |= env(data_arg)' "${values_yaml}"
  fi

  perl -pi -e "s/'//g" "${file}"
}

function update_clusterrolebinding_resource() {
  readonly file="${1}"
  readonly name=$(yq e '.metadata.name' "${file}")

  if [ "${name}" != 'clickhouse-operator-kube-system' ]; then
    echo "do not know how to process ${name} cluster role binding"
    exit 1
  fi

  yq e -i '.metadata.name |= "{{ include \"altinity-clickhouse-operator.fullname\" . }}"' "${file}"
  yq e -i '.metadata.namespace |= "{{ .Release.Namespace }}"' "${file}"
  yq e -i '.metadata.labels |= "{{ include \"altinity-clickhouse-operator.labels\" . | nindent 4 }}"' "${file}"
  yq e -i '.roleRef.name |= "{{ include \"altinity-clickhouse-operator.fullname\" . }}"' "${file}"
  yq e -i '(.subjects[] | select(.kind == "ServiceAccount")) |= with(. ; .name = "{{ include \"altinity-clickhouse-operator.serviceAccountName\" . }}" | .namespace = "{{ .Release.Namespace }}")' "${file}"

  perl -pi -e "s/'//g" "${file}"
}

function update_clusterrole_resource() {
  readonly file="${1}"
  readonly name=$(yq e '.metadata.name' "${file}")

  if [ "${name}" != 'clickhouse-operator-kube-system' ]; then
    echo "do not know how to process ${name} cluster role"
    exit 1
  fi

  yq e -i '.metadata.name |= "{{ include \"altinity-clickhouse-operator.fullname\" . }}"' "${file}"
  yq e -i '.metadata.namespace |= "{{ .Release.Namespace }}"' "${file}"
  yq e -i '.metadata.labels |= "{{ include \"altinity-clickhouse-operator.labels\" . | nindent 4 }}"' "${file}"

  yq e -i '(.rules[] | select(.resourceNames | contains(["clickhouse-operator"])) | .resourceNames) = ["{{ include \"altinity-clickhouse-operator.fullname\" . }}"]' "${file}"

  perl -pi -e "s/'//g" "${file}"
}

function update_serviceaccount_resource() {
  readonly file="${1}"
  readonly name=$(yq e '.metadata.name' "${file}")

  if [ "${name}" != 'clickhouse-operator' ]; then
    echo "do not know how to process ${name} service account"
    exit 1
  fi

  yq e -i '.metadata.name |= "{{ include \"altinity-clickhouse-operator.serviceAccountName\" . }}"' "${file}"
  yq e -i '.metadata.namespace |= "{{ .Release.Namespace }}"' "${file}"
  yq e -i '.metadata.labels |= "{{ include \"altinity-clickhouse-operator.labels\" . | nindent 4 }}"' "${file}"
  yq e -i '.metadata.annotations |= "{{ toYaml .Values.serviceAccount.annotations | nindent 4 }}"' "${file}"

  printf '%s\n%s\n' '{{- if .Values.serviceAccount.create -}}' "$(cat "${file}")" >"${file}"
  printf '%s\n%s\n' "$(cat "${file}")" '{{- end -}}' >"${file}"

  perl -pi -e "s/'//g" "${file}"
}

function update_secret_resource() {
  readonly file="${1}"
  readonly name=$(yq e '.metadata.name' "${file}")

  if [ "${name}" != 'clickhouse-operator' ]; then
    echo "do not know how to process ${name} secret"
    exit 1
  fi

  yq e -i '.metadata.name |= "{{ include \"altinity-clickhouse-operator.fullname\" . }}"' "${file}"
  yq e -i '.metadata.namespace |= "{{ .Release.Namespace }}"' "${file}"
  yq e -i '.metadata.labels |= "{{ include \"altinity-clickhouse-operator.labels\" . | nindent 4 }}"' "${file}"

  yq e -i '.data.username |= "{{ .Values.secret.username | b64enc }}"' "${file}"
  yq e -i '.data.password |= "{{ .Values.secret.password | b64enc }}"' "${file}"

  readonly username=$(yq e '.stringData.username' "${file}")
  yq e -i '.secret.username |= "'"${username}"'"' "${values_yaml}"

  readonly password=$(yq e '.stringData.password' "${file}")
  yq e -i '.secret.password |= "'"${password}"'"' "${values_yaml}"

  yq e -i 'del(.stringData)' "${file}"

  printf '%s\n%s\n' '{{- if .Values.secret.create -}}' "$(cat "${file}")" >"${file}"
  printf '%s\n%s\n' "$(cat "${file}")" '{{- end -}}' >"${file}"

  perl -pi -e "s/'//g" "${file}"
}

function to_camel_case() {
  readonly str="${1}"
  echo "${str}" | awk -F - '{printf "%s", $1; for(i=2; i<=NF; i++) printf "%s", toupper(substr($i,1,1)) substr($i,2); print"";}'
}

function detect_version() {
  yq e '.appVersion' ${chart_def}
}

main
