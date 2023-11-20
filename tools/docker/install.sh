#!/bin/sh
set -eux

# original reference: https://github.com/docker-library/docker/blob/cbb0ee05d8be7b73d6b482c4a602be137e108f77/18.09/Dockerfile

DOCKER_CHANNEL=stable
# renovate: datasource=github-releases depName=moby/moby extractVersion=^v(?<version>.*)$
DOCKER_VERSION=24.0.6
SHA=637cc54b751c96ff0b9a8e6e975e4306ff8bd846933ecf9080f2296c3d000778924765bd2422989eb1aa0d4a5244893b265834fa5f361a9f48c7c37251e9b9c0
dockerArch=x86_64

if ! wget -O docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${dockerArch}/docker-${DOCKER_VERSION}.tgz"; then
  echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from '${DOCKER_CHANNEL}' for '${dockerArch}'"
  exit 1
fi

tar \
  --extract \
  --file docker.tgz \
  --strip-components 1 \
  --directory /usr/local/bin/

echo "${SHA}  docker.tgz" | sha512sum -c -

rm docker.tgz

dockerd --version
docker --version
