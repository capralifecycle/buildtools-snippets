# Using the provided script.
FROM alpine@sha256:074d3636ebda6dd446d0d00304c4454f468237fdacf08fb0eeac90bdbfa1bac7
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM debian:sid@sha256:1999dde0d998fba777fc942493fa4f277e4658eb0b5152c738f97a1268c3af3c
RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip wget; \
    rm -rf /var/lib/apt/lists/*
COPY tools/sonar-scanner/install.sh /install.sh
RUN /install.sh
RUN sonar-scanner --version

# Using the provided script.
FROM openjdk:8-jre@sha256:1b7083c5b2fa87ab7b8e87b4a761945267fc8fe5ae42252e592f083cd5674d76
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
FROM alpine@sha256:074d3636ebda6dd446d0d00304c4454f468237fdacf08fb0eeac90bdbfa1bac7
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
