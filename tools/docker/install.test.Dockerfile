# Using the provided script.
FROM alpine@sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c2fa221cf1a824e6a
COPY tools/docker/install.sh /install.sh
RUN /install.sh
RUN docker --version

# Using the provided script.
FROM debian:sid@sha256:2726a7c64ee9ef8bc5c8595d053b90161a6b31094fb364e642651bd82029a3e6
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
FROM alpine@sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c2fa221cf1a824e6a
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/docker/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    docker --version
