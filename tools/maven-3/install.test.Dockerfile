# Using the provided script.
FROM azul/zulu-openjdk-alpine:11@sha256:e835fa5dd337d72d93b5b9d9a2c640468dda13842d8f00b5ede4b5bcb8d7e571
COPY tools/maven-3/install.sh /install.sh
RUN /install.sh
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN mvn -version

# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:afbbc17b7c8e407926ab8c3d09e5f70ac8be2169626d5be7bee19f6bf1e922d9
RUN set -ex; \
    apt-get update; \
    apt-get install -y wget; \
    rm -rf /var/lib/apt/lists/*
COPY tools/maven-3/install.sh /install.sh
RUN /install.sh
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN mvn -version

# Ensuring the direct url works.
# Tip: Copy the ENV and RUN command to another Dockerfile to include it,
# but change ${BRANCH} to master.
FROM azul/zulu-openjdk-alpine:11@sha256:e835fa5dd337d72d93b5b9d9a2c640468dda13842d8f00b5ede4b5bcb8d7e571
ARG BRANCH
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/maven-3/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    mvn -version
