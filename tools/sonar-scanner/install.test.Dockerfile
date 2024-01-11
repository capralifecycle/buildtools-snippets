# Using the provided script.
FROM alpine@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48
COPY tools/sonar-scanner/install.sh /install.sh
RUN apk add --no-cache gnupg
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:72965f6772e040718fbbfdb0ce7f44de48014899e2d1726207a4238048f16ec5
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget gnupg; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM azul/zulu-openjdk-alpine:11.0.21-jre@sha256:0e1dd8bfd9c647f1b7aa75d91cd8f82addc495f5f4b56626d0c0ec68dd750a88
COPY tools/sonar-scanner/install.sh /install.sh
RUN apk add --no-cache gnupg
RUN /install.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:51b67269f354137895d43f3b3d810bfacd3945438e94dc5ac55fdac340352f48
ARG BRANCH
RUN apk add --no-cache gnupg
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
