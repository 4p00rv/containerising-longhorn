#!/bin/sh
set -xe
GITHUB_URL=https://github.com/k3s-io/k3s/releases
LATEST_VERSION=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
VERSION_TO_BUILD="${LATEST_VERSION}"
export ALPINE_VERSION=$(curl  -L -s -S https://raw.githubusercontent.com/k3s-io/k3s/${VERSION_TO_BUILD}/package/Dockerfile | grep 'FROM alpine:' | cut -d ' ' -f 2)
export K3S_VERSION=$(echo ${VERSION_TO_BUILD} | sed -e 's|\+|-|')
IMAGE_TAG="local/k3s:${1:-latest}"
echo "Building k3s ${VERSION_TO_BUILD} and publishing ${IMAGE_TAG} (from rancher/k3s:${VERSION_TO_BUILD})"
envsubst < Dockerfile.template > Dockerfile
docker build -t ${IMAGE_TAG} .
rm Dockerfile
#cat Dockerfile.template | sed "s/ALPINE_VERSION/${ALPINE_VERSION}/" | sed "s/K3S_VERSION/${K3S_VERSION}/" | docker build -t ${IMAGE_TAG} .
