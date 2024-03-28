# Using the provided script.
FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b
COPY tools/sonar-scanner/install.sh /install.sh
RUN apk add --no-cache gnupg
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:673f1df9f3c1b47a296ec9df98e0386f82d405bcbd845edd1bafc1bfde9661f3
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget gnupg; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM azul/zulu-openjdk-alpine:21.0.1-jre@sha256:5a42281f453472986982bd9d7b3f2aa44a40e3bdc3a150d78e36f3eb2d3ef1ad
COPY tools/sonar-scanner/install.sh /install.sh
RUN apk add --no-cache gnupg
RUN /install.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b
ARG BRANCH
RUN apk add --no-cache gnupg
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
