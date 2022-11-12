# Using the provided script.
FROM alpine@sha256:b95359c2505145f16c6aa384f9cc74eeff78eb36d308ca4fd902eeeb0a0b161b
COPY tools/docker/install.sh /install.sh
RUN /install.sh
RUN docker --version

# Using the provided script.
FROM debian:sid@sha256:25374e99cbc8c51bf1f6ec82e96edbbf51845e61b92aa3be4270af686d3f0801
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
FROM alpine@sha256:b95359c2505145f16c6aa384f9cc74eeff78eb36d308ca4fd902eeeb0a0b161b
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/docker/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    docker --version
