# Using the provided script.
FROM azul/zulu-openjdk-debian:17@sha256:d5c77e31940743bc21335e83a042d11b7eccd29461ac1a803c3845e9f7a3d9ec
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:17@sha256:d5c77e31940743bc21335e83a042d11b7eccd29461ac1a803c3845e9f7a3d9ec
ARG BRANCH
RUN set -ex; \
    apt-get update; \
    apt-get install -y wget; \
    rm -rf /var/lib/apt/lists/*
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/node/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    node --version; \
    npm --version
