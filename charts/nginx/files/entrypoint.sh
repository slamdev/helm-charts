#!/bin/sh

set -o errexit
set -o nounset

NGINX_BIN=nginx
if [ "${NGINX_DEBUG}" = "true" ]; then
  NGINX_BIN=nginx-debug
fi

CONF_DIR=/etc/nginx/

cp "${CONF_DIR}/nginx.conf.tpl" "${CONF_DIR}/nginx.conf"
perl -pi -e 's/ENV_([_A-Z0-9]+)_ENV/$ENV{$1}/g' "${CONF_DIR}/nginx.conf"

${NGINX_BIN} -g 'daemon off;'
