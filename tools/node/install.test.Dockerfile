# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:c9319aa2d9d8f065fb1657062e77858d20b3ae9803a7e2e10dc2cb13e69ca5ce
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:c9319aa2d9d8f065fb1657062e77858d20b3ae9803a7e2e10dc2cb13e69ca5ce
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
