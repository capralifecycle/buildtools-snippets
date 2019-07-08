# Using the provided script.
FROM alpine
COPY tools/sonar-scanner/install-alpine.sh /install-alpine.sh
RUN /install-alpine.sh
RUN sonar-scanner --version

# Ensuring the url still works.
# Note: This will break only after merging!
FROM alpine
RUN wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/master/tools/sonar-scanner/install-alpine.sh -O- | sh
RUN sonar-scanner --version
