# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:92f69d264ea39b661ee1eb45b29d8e6daf1b728dddb91c7e1d8bc2aaaf3d68cf
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:92f69d264ea39b661ee1eb45b29d8e6daf1b728dddb91c7e1d8bc2aaaf3d68cf
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
