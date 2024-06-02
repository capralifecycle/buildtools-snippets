# Using the provided script.
FROM azul/zulu-openjdk-debian:21.0.3@sha256:fdcb383313be084d3b9a0948812cd8cf92c0efb93f36b7c5f27b830f68d8ba26
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:21.0.3@sha256:fdcb383313be084d3b9a0948812cd8cf92c0efb93f36b7c5f27b830f68d8ba26
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
