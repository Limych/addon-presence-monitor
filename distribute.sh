#!/bin/bash
set -ev

ROOT_DIR=$(dirname "$(readlink -f "$0")")

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
    echo "This build is a pull request, aborting distribution script."
    exit 0
fi

if [ ! -z "$TRAVIS_TAG" ]; then
    echo "Tagged build found. Pushing container image to Docker with tag 'latest'."

    docker run -it --rm --privileged --name "${ADDON_NAME}" \
        -v "${ROOT_DIR}":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME}" \
        --tag-latest \
        --push \
        --all \
        --author "Andrey Khrolenok <andrey@khrolenok.ru>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel
else
    echo "No tag found."
    if [ "$TRAVIS_BRANCH" != "master" ]; then
        echo "Not on master branch. Aborting distribution script"
        exit 0
    fi
    echo "Untagged push to master branch identified. Pushing container image to Docker with tag 'test'."

    docker run -it --rm --privileged --name "${ADDON_NAME}" \
        -v "${ROOT_DIR}":/docker \
        hassioaddons/build-env:latest \
        --target "${ADDON_NAME}" \
        --tag-test \
        --push \
        --all \
        --author "Andrey Khrolenok <andrey@khrolenok.ru>" \
        --doc-url "${GITHUB_URL}" \
        --login "${DOCKER_USERNAME}" \
        --password "${DOCKER_PASSWORD}" \
        --parallel
fi
