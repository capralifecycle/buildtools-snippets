# Using the provided script.
FROM azul/zulu-openjdk-alpine:11.0.23@sha256:44b047bc7aa31991db88acdac2a2c841bca0cd5f2715f104d46d8a91aa05e2ff
COPY tools/maven-3/install.sh /install.sh
RUN /install.sh
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN mvn -version

# Using the provided script.
FROM azul/zulu-openjdk-debian:11.0.23@sha256:cbaaaddeb115ae240ff7d972ce67fbc4a0012bd7edfb12f99fab9ea155fa4dfa
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
FROM azul/zulu-openjdk-alpine:11.0.23@sha256:44b047bc7aa31991db88acdac2a2c841bca0cd5f2715f104d46d8a91aa05e2ff
ARG BRANCH
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/maven-3/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    mvn -version
