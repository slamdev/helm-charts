#!/bin/bash

set -o errexit
set -o nounset

CHART_PATH=..
BUILD_PATH="${CHART_PATH}/../../build"

APP_VERSION=$(cat "${CHART_PATH}/Chart.yaml" | grep appVersion | cut -d : -f 2 | xargs)

if [ "${APP_VERSION}" = "latest" ]; then
  APP_VERSION="master"
fi

REPO_URL="https://raw.githubusercontent.com/Altinity/clickhouse-operator/${APP_VERSION}/deploy/operator"

function extract_resources() {
  local url=$1
  local dest=$2

  local resources
  resources=$(curl -s "${url}" | yq e -j -N | jq . -c)

  OLDIFS=$IFS
  IFS=$'\n'
  for r in ${resources}; do
    local kind
    kind=$(echo "${r}" | jq .kind -r)

    local name
    name=$(echo "${r}" | jq .metadata.name -r)

    echo "${r}" | yq e -P - >"${dest}/${kind}-${name}.yaml"
  done
  IFS=$OLDIFS
}

rm -rf "${CHART_PATH}/crds"  "${CHART_PATH}/tmp"
mkdir "${CHART_PATH}/crds"  "${CHART_PATH}/tmp"


extract_resources "${REPO_URL}/clickhouse-operator-install-bundle.yaml" "${CHART_PATH}/tmp"
cp ${CHART_PATH}/tmp/CustomResourceDefinition-* ${CHART_PATH}/crds/
cat ${CHART_PATH}/tmp/ClusterRoleBinding-* > ${CHART_PATH}/templates/rbac.yaml
echo "---" >> ${CHART_PATH}/templates/rbac.yaml
cat ${CHART_PATH}/tmp/ClusterRole-* >> ${CHART_PATH}/templates/rbac.yaml
cp ${CHART_PATH}/tmp/ConfigMap-* ${CHART_PATH}/templates/generated/
cp ${CHART_PATH}/tmp/Deployment-clickhouse-operator.yaml ${CHART_PATH}/templates/generated/
cp ${CHART_PATH}/tmp/Service-clickhouse-operator-metrics.yaml ${CHART_PATH}/templates/generated/
rm -rf "${CHART_PATH}/tmp"
#extract_resources "${REPO_URL}/clickhouse-operator-install-deployment.yaml" "${CHART_PATH}/templates/generated"
#extract_resources "${REPO_URL}/clickhouse-operator-install-service.yaml" "${CHART_PATH}/templates/generated"

exit 1

wget -O ${BUILD_PATH}/repo.zip ${REPO_URL}
unzip -n "${BUILD_PATH}/repo.zip" -d ${BUILD_PATH}
rm "${BUILD_PATH}/repo.zip"

REPO_PATH="${BUILD_PATH}/external-secrets-operator-${APP_VERSION}"

cp -R "${REPO_PATH}/config/samples/" "${CHART_PATH}/examples/"

rm -rf xx* && csplit -s -k ${REPO_PATH}/k8s/k8s.yaml '/^---/' '{99}' || true

for f in xx*; do
  name="$(yq r "${f}" 'kind' | tr '[:upper:]' '[:lower:]')-$(yq r "${f}" 'metadata.name' | tr '[:upper:]' '[:lower:]')"
  if [[ "${name}" == "namespace"* ]]; then
    rm "${f}"
    continue
  fi
  mv "${f}" "${CHART_PATH}/templates/${name}.yaml"
done
