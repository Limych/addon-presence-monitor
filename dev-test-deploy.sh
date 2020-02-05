#!/usr/bin/env bash

readonly __COLORS_ESCAPE="\033[";
readonly __COLORS_RESET="${__COLORS_ESCAPE}0m"
readonly __COLORS_RED="${__COLORS_ESCAPE}31m"
readonly __COLORS_GREEN="${__COLORS_ESCAPE}32m"
readonly __COLORS_MAGENTA="${__COLORS_ESCAPE}35m"

log.fatal() {
    local message=$*
    echo -e "${__COLORS_RED}${message}${__COLORS_RESET}" >&2
}

log.error() {
    local message=$*
    echo -e "${__COLORS_MAGENTA}${message}${__COLORS_RESET}" >&2
}

log.info() {
    local message=$*
    echo -e "${__COLORS_GREEN}${message}${__COLORS_RESET}" >&2
}

die() {
    local message=${1:-}
    local code=${2:-1}
    if [[ -n "${message}" ]]; then
        log.fatal "${message}"
    fi
    exit "${code}"
}



ROOT_DIR=$(dirname "$(readlink -f "$0")")

set -a
. "${ROOT_DIR}/.env.dev"
set +a

ADDON_NAME="presence-monitor"

HASSIO_ADDONS="${ROOT_DIR}/dev-addons"
ADDON_LOCAL_DIR="${ROOT_DIR}/${ADDON_NAME}"
ADDON_HASSIO_DIR="${HASSIO_ADDONS}/${ADDON_NAME}"
GITHUB_URL="$( cat "${ADDON_LOCAL_DIR}/config.json" | jq '.url' )"

if [[ -d "${ADDON_HASSIO_DIR}" ]]; then
    log.info "Removing old version of addon..."
    rm -Rf "${ADDON_HASSIO_DIR}"
fi

log.info "Copy new version of addon..."
cp -R "${ADDON_LOCAL_DIR}" "${HASSIO_ADDONS}/"
sed '/"image":/d' "${ADDON_LOCAL_DIR}/config.json" >"${ADDON_HASSIO_DIR}/config.json"

#log.info "Build addon docker container..."
#docker run -t --rm --privileged --name "${ADDON_NAME}" \
#    -v "${ROOT_DIR}":/docker \
#    hassioaddons/build-env:latest \
#    --target "${ADDON_NAME}" \
#    --git \
#    --push \
#    --all \
#    --author "Andrey Khrolenok <andrey@khrolenok.ru>" \
#    --doc-url "${GITHUB_URL}" \
#    --login "${DOCKER_USERNAME}" \
#    --password "${DOCKER_PASSWORD}" \
#    --parallel
