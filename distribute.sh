#!/bin/bash
set -ev

ROOT_DIR=$(dirname "$(readlink -f "$0")")

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    echo "This build is a pull request, aborting distribution script."
    exit 0
fi

docker run -it --rm --privileged --name "${ADDON_NAME}" \
    -v "${ROOT_DIR}":/docker \
    hassioaddons/build-env:latest \
    --target "${ADDON_NAME}" \
    --git \
    --push \
    --all \
    --author "Andrey Khrolenok <andrey@khrolenok.ru>" \
    --doc-url "${GITHUB_URL}" \
    --login "${DOCKER_USERNAME}" \
    --password "${DOCKER_PASSWORD}" \
    --parallel
