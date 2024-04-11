# Using the provided script.
FROM azul/zulu-openjdk-debian:11.0.22@sha256:6bbdaa726846085fd90a4afb9ecd6df9f333e7c30d6f40918b80f6bbaac3293e
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11.0.22@sha256:6bbdaa726846085fd90a4afb9ecd6df9f333e7c30d6f40918b80f6bbaac3293e
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
