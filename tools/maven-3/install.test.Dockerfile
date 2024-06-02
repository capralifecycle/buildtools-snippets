# Using the provided script.
FROM azul/zulu-openjdk-alpine:11.0.23@sha256:99f84e86596c41ccfe5a77980b055ff1c3fd8899ae9208a48b8c596a853056d4
COPY tools/maven-3/install.sh /install.sh
RUN /install.sh
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN mvn -version

# Using the provided script.
FROM azul/zulu-openjdk-debian:21.0.3@sha256:fdcb383313be084d3b9a0948812cd8cf92c0efb93f36b7c5f27b830f68d8ba26
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
FROM azul/zulu-openjdk-alpine:11.0.23@sha256:99f84e86596c41ccfe5a77980b055ff1c3fd8899ae9208a48b8c596a853056d4
ARG BRANCH
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/maven-3/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    mvn -version
