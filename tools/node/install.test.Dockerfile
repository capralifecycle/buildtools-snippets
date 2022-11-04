# Using the provided script.
FROM azul/zulu-openjdk-debian:19@sha256:fe8c6513b424c223a341b7dfad7e87cc6dc7e736deff0bc3e67ab220b6506cbc
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:19@sha256:fe8c6513b424c223a341b7dfad7e87cc6dc7e736deff0bc3e67ab220b6506cbc
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
