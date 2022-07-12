# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:9d4c571416aabc9b5e7c3830afc2c39a79abeda58c1acee4dcf57b71aa402807
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:9d4c571416aabc9b5e7c3830afc2c39a79abeda58c1acee4dcf57b71aa402807
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
