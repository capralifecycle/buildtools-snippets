# Using the provided script.
FROM alpine
COPY tools/sonar-scanner/install-alpine.sh /install-alpine.sh
RUN /install-alpine.sh
RUN sonar-scanner --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/sonar-scanner/install-alpine.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    sonar-scanner --version
