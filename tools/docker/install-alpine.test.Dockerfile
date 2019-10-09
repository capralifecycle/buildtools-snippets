# Using the provided script.
FROM alpine
COPY tools/docker/install-alpine.sh /install-alpine.sh
RUN /install-alpine.sh
RUN docker --version

# Ensuring the direct url works.
# Tip: Copy the RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM alpine
ARG BRANCH
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/docker/install-alpine.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    docker --version
