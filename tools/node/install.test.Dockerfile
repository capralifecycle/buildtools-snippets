# Using the provided script.
FROM azul/zulu-openjdk-debian:11.0.21@sha256:4c0328962f3e4024879bed6e3cb79279b4fc9833c40616e03fa8fc52cdaa9eba
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11.0.21@sha256:4c0328962f3e4024879bed6e3cb79279b4fc9833c40616e03fa8fc52cdaa9eba
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
