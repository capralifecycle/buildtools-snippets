# Using the provided script.
FROM azul/zulu-openjdk-debian:11.0.21@sha256:36dbd95118dee43d6c91c0fc8958ece0bf2fc6a8b0ea351e56f6df6b8b12d0d0
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11.0.21@sha256:36dbd95118dee43d6c91c0fc8958ece0bf2fc6a8b0ea351e56f6df6b8b12d0d0
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
