# Using the provided script.
FROM alpine@sha256:08d6ca16c60fe7490c03d10dc339d9fd8ea67c6466dea8d558526b1330a85930
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:4ae5284ee9adbb10397cbc5343aaaafa34ff9f58f6d5c51589d3ba41ddcae4df
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM openjdk:8-jre@sha256:07b9849a5d82f5d172b7d9d3136fb3f47709bda0d82ae5452c107311c83a4652
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM azul/zulu-openjdk-alpine:11-jre@sha256:37f8511c61924dc65e1e956ba308051f49805645d8842f74f0fa46187a9d6eeb
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:08d6ca16c60fe7490c03d10dc339d9fd8ea67c6466dea8d558526b1330a85930
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
