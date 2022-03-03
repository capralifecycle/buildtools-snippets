# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:367d2d49af96ad4a7e5d1987aa73dce7539274402426069190fdb2837265c8d6
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:367d2d49af96ad4a7e5d1987aa73dce7539274402426069190fdb2837265c8d6
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
