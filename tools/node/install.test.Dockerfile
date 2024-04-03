# Using the provided script.
FROM azul/zulu-openjdk-debian:11.0.22@sha256:1e0438258531a74df1b80272e0191b3895968044eb2b6297ab7ca7d43e04ac9e
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11.0.22@sha256:1e0438258531a74df1b80272e0191b3895968044eb2b6297ab7ca7d43e04ac9e
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
