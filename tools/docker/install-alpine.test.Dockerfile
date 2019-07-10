# Using the provided script.
FROM alpine
COPY tools/docker/install-alpine.sh /install-alpine.sh
RUN /install-alpine.sh
RUN docker --version

# Ensuring the url still works.
# Note: This will break only after merging!
# Tip: Copy the RUN command to another Dockerfile to include it.
FROM alpine
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/master/tools/docker/install-alpine.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    docker --version
