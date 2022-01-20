# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:9c9bb9f7e4cda1bdb9d1a4ec7d9a05c46ad7b91b276b05717bb8aff34b9e0541
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:9c9bb9f7e4cda1bdb9d1a4ec7d9a05c46ad7b91b276b05717bb8aff34b9e0541
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
