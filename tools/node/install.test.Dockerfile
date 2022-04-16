# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:7977f7d15488456a35261105e35f072b9ad37c904a2ff405c22bbe6c001a4960
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:7977f7d15488456a35261105e35f072b9ad37c904a2ff405c22bbe6c001a4960
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
