# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:d7edd8d2df2a7e0a9a0dfb09d40cf1349f22c3196eaab5563d7cbedc4b7c8005
COPY tools/node/install.sh /install.sh
RUN /install.sh
RUN node --version
RUN npm --version

# Ensuring the direct url works.
# Tip: Copy RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-debian:11@sha256:d7edd8d2df2a7e0a9a0dfb09d40cf1349f22c3196eaab5563d7cbedc4b7c8005
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
