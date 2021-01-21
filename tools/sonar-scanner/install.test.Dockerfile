# Using the provided script.
FROM alpine@sha256:d0710affa17fad5f466a70159cc458227bd25d4afb39514ef662ead3e6c99515
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:a18dac4e50f8f7f0a730d86ba6bb1666cf1179ef027d45084b9bd8b2735bfa5b
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM openjdk:8-jre@sha256:ad6141870180cf0ca626367a409950acfa80e4405761a750361bdc4dbb96cfcb
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM azul/zulu-openjdk-alpine:11-jre@sha256:5fa775b9eee78716a2057819b66d5aa7642e53dcfc613e1c7bbe3b0ee1542efb
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:d0710affa17fad5f466a70159cc458227bd25d4afb39514ef662ead3e6c99515
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
