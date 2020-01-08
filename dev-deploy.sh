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



ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

HASSIO_ADDONS="${ROOT}/dev-addons"
ADDON="presence-monitor"

if [[ -d "${HASSIO_ADDONS}/${ADDON}" ]]; then
    log.info "Removing old version of addon..."
    rm -Rf "${HASSIO_ADDONS}/${ADDON}"
fi

log.info "Copy new version of addon..."
cp -R "${ROOT}/${ADDON}" "${HASSIO_ADDONS}/"
sed '/"image":/d' "${ROOT}/${ADDON}/config.json" >"${HASSIO_ADDONS}/${ADDON}/config.json"
