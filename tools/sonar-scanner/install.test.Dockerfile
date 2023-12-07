# Using the provided script.
FROM alpine@sha256:34871e7290500828b39e22294660bee86d966bc0017544e848dd9a255cdf59e0
COPY tools/sonar-scanner/install.sh /install.sh
RUN apk add --no-cache gnupg
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:fa18eda6ea249fb990480b808065cafd6e7bda87d8ce65f2418f92c77f046bea
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget gnupg; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM azul/zulu-openjdk-alpine:11.0.21-jre@sha256:11a887f92c335b9c964309496a1711e78defa89a2da7846288a774f2d2decd81
COPY tools/sonar-scanner/install.sh /install.sh
RUN apk add --no-cache gnupg
RUN /install.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine@sha256:34871e7290500828b39e22294660bee86d966bc0017544e848dd9a255cdf59e0
ARG BRANCH
RUN apk add --no-cache gnupg
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
