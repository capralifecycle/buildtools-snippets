# Using the provided script.
FROM azul/zulu-openjdk-alpine:11@sha256:de39bc1d0b58ad7847a7d4a79dc4216a72ed7dd56fb7e5e69496bf05138ed907
COPY tools/maven-3/install.sh /install.sh
RUN /install.sh
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN mvn -version

# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:9d4c571416aabc9b5e7c3830afc2c39a79abeda58c1acee4dcf57b71aa402807
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
FROM azul/zulu-openjdk-alpine:11@sha256:de39bc1d0b58ad7847a7d4a79dc4216a72ed7dd56fb7e5e69496bf05138ed907
ARG BRANCH
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/maven-3/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    mvn -version
