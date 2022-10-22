# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:cba9fac6c0ca1032aca2a133d54eeb19d2c2a7a60f6db8f4f5a01ba5e8309a87
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:cba9fac6c0ca1032aca2a133d54eeb19d2c2a7a60f6db8f4f5a01ba5e8309a87
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
