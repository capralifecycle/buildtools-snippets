#!/bin/sh
set -eux

# inspired by https://github.com/nodejs/docker-node/blob/ad676318f09f9dee821ac6704340000d75fe31bc/14/buster-slim/Dockerfile

# renovate: datasource=github-releases depName=nodejs/node extractVersion=^v(?<version>.*)$
NODE_VERSION=21.7.3

apt-get update
apt-get install -y --no-install-recommends \
  curl \
  dirmngr \
  gnupg \
  xz-utils
rm -rf /var/lib/apt/lists/*

# gpg keys listed at https://github.com/nodejs/node#release-keys
for key in \
  4ED778F539E3634C779C87C6D7062848A1AB005C \
  94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
  1C050899334244A8AF75E53792EF661D867B9DFA \
  71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
  8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
  C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  C82FA3AE1CBEDC6BE46B9360C43CEC45C17AB93C \
  DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
  A48C2BEE680E841632CD4E44F07496B3EB3C1762 \
  108F52B48DB57BB0CC439B2997B01419BD92F80A \
  B9E2F5981AA6E0CD28160D9FF13993A75599653C \
; do \
  gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" ; \
done

ARCH=x64

curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz"
curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc"
gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc
grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c -
tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner
rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt
ln -s /usr/local/bin/node /usr/local/bin/nodejs

# smoke tests
node --version
npm --version
