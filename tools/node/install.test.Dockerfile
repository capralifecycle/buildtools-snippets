# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:1cb208eb9d3d8b64f44dc0eff88da53a95c4fcce654a9b7c2e4d741ab6d836bd
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:1cb208eb9d3d8b64f44dc0eff88da53a95c4fcce654a9b7c2e4d741ab6d836bd
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
