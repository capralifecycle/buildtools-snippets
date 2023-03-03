# Using the provided script.
FROM alpine@sha256:69665d02cb32192e52e07644d76bc6f25abeb5410edc1c7a81a10ba3f0efb90a
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:3c4f1e8364c4cf8ad11fd7d21aeec8055e899a2b1796b57f800ea11b7ec4ec35
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM azul/zulu-openjdk-alpine:11-jre@sha256:3d2a81764c3d9e815a0a35e3c455e43baa13e8004066b2c8a864e66cb5362a9a
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:69665d02cb32192e52e07644d76bc6f25abeb5410edc1c7a81a10ba3f0efb90a
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
