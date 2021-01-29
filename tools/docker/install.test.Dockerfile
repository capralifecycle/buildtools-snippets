# Using the provided script.
FROM alpine@sha256:08d6ca16c60fe7490c03d10dc339d9fd8ea67c6466dea8d558526b1330a85930
COPY tools/docker/install.sh /install.sh
RUN /install.sh
RUN docker --version

# Using the provided script.
FROM debian:sid@sha256:5e6a1ee970b7545c633e3fd675dfb8bf0ec19132dc209c2852cb02bd4213823c
RUN set -ex; \
    apt-get update; \
    apt-get install -y wget; \
    rm -rf /var/lib/apt/lists/*
COPY tools/docker/install.sh /install.sh
RUN /install.sh
RUN docker --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:08d6ca16c60fe7490c03d10dc339d9fd8ea67c6466dea8d558526b1330a85930
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/docker/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    docker --version
