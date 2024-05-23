# Using the provided script.
FROM alpine@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd
COPY tools/sonar-scanner/install.sh /install.sh
RUN apk add --no-cache gnupg
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:22bbe53d77cdc334b74771f2c0d9412db2e21f0055969d8ac2427cb70eed0c50
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget gnupg; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM azul/zulu-openjdk-alpine:11.0.23-jre@sha256:713b1af99dbfb0d4b56dd47cc2d7b4bf5f0b6b4feb0f3bbd4ee8099c56ba41ba
COPY tools/sonar-scanner/install.sh /install.sh
RUN apk add --no-cache gnupg
RUN /install.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd
ARG BRANCH
RUN apk add --no-cache gnupg
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
