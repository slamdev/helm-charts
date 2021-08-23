#!/bin/bash

set -o errexit
set -o nounset

CHART_PATH=../
BUILD_PATH="${CHART_PATH}/../../build"

APP_VERSION=$(cat "${CHART_PATH}/Chart.yaml" | grep appVersion | cut -d : -f 2 | xargs)

if [ "${APP_VERSION}" = "latest" ]; then
  APP_VERSION="main"
fi

REPO_URL="https://github.com/slamdev/config-connector-templater/archive/${APP_VERSION}.zip"

mkdir -p "${BUILD_PATH}"

wget -O ${BUILD_PATH}/repo.zip ${REPO_URL}
unzip -n "${BUILD_PATH}/repo.zip" -d ${BUILD_PATH}
rm "${BUILD_PATH}/repo.zip"

REPO_PATH="${BUILD_PATH}/config-connector-templater-${APP_VERSION}"
#REPO_PATH="/Users/slam/workspace/slamdev/config-connector-templater"

cp -R "${REPO_PATH}/config/samples/" "${CHART_PATH}/examples/"
rm -rf "${CHART_PATH}/examples/kustomization.yaml"

YAMLS=$(kustomize build "${REPO_PATH}/config/default/")

DOCS_LENGTH=$(echo "${YAMLS}" | yq ea -j . - | jq -s length)

for ((i = 0; i < "${DOCS_LENGTH}"; i++)); do
  DOC=$(echo "${YAMLS}" | yq ea "select(documentIndex == ${i})" -)
  KIND=$(echo "${DOC}" | yq e '.kind' - | tr '[:upper:]' '[:lower:]')
  if [ "${KIND}" = "namespace" ]; then
    continue
  fi
  NAME=$(echo "${DOC}" | yq e '.metadata.name' - | tr '[:upper:]' '[:lower:]')
  if [ "${KIND}" = "customresourcedefinition" ]; then
    echo "${DOC}" >"${CHART_PATH}/crds/${NAME}.yaml"
  else
    echo "${DOC}" >"${CHART_PATH}/templates/${KIND}-${NAME}.yaml"
  fi
done
