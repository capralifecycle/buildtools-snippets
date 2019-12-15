#!/bin/sh
set -eux

# original reference: https://github.com/docker-library/docker/blob/cbb0ee05d8be7b73d6b482c4a602be137e108f77/18.09/Dockerfile

# See check-updates.sh.
DOCKER_CHANNEL=stable
DOCKER_VERSION=19.03.5
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

rm docker.tgz

dockerd --version
docker --version
