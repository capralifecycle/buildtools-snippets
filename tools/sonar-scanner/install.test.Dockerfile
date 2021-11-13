# Using the provided script.
FROM alpine@sha256:635f0aa53d99017b38d1a0aa5b2082f7812b03e3cdb299103fe77b5c8a07f1d2
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:4e85ef0d6eac69c503ba9e4b4b1957c77468ecbe2c38e453ed0cc0ee0e709869
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM azul/zulu-openjdk-alpine:11-jre@sha256:7d3e251b70b7eb7e14c95b82e882734b2ea682a83fa99167f1f3b72f4b0281ba
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:635f0aa53d99017b38d1a0aa5b2082f7812b03e3cdb299103fe77b5c8a07f1d2
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
