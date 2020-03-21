#!/bin/bash

set -o errexit
set -o nounset

CHART_PATH=../
BUILD_PATH="${CHART_PATH}/../../build"

APP_VERSION=$(cat "${CHART_PATH}/Chart.yaml" | grep appVersion | cut -d : -f 2 | xargs)

if [ "${APP_VERSION}" = "latest" ]; then
  APP_VERSION="master"
fi

REPO_URL="https://github.com/slamdev/external-secrets-operator/archive/${APP_VERSION}.zip"

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
