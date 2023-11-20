# Using the provided script.
FROM azul/zulu-openjdk-debian:11.0.21@sha256:0beb5bd3549e80f6fb2b646870e4f25c63923cddcd20f9ce2ec6456c125f8218
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11.0.21@sha256:0beb5bd3549e80f6fb2b646870e4f25c63923cddcd20f9ce2ec6456c125f8218
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
