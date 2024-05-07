# Using the provided script.
FROM azul/zulu-openjdk-debian:11.0.23@sha256:cf0c7202b99c6d88b20e16ec5edc95b11ab59c485015ccd12f6621405cec5d0b
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11.0.23@sha256:cf0c7202b99c6d88b20e16ec5edc95b11ab59c485015ccd12f6621405cec5d0b
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
