# Using the provided script.
FROM azul/zulu-openjdk-alpine:11@sha256:c6b49e2cf00fb03dd55243aa25d4dcd91a009538c276182d2422657edf9866fa
COPY tools/maven-3/install.sh /install.sh
RUN /install.sh
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN mvn -version

# Using the provided script.
FROM azul/zulu-openjdk-debian:11@sha256:d7edd8d2df2a7e0a9a0dfb09d40cf1349f22c3196eaab5563d7cbedc4b7c8005
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
FROM azul/zulu-openjdk-alpine:11@sha256:c6b49e2cf00fb03dd55243aa25d4dcd91a009538c276182d2422657edf9866fa
ARG BRANCH
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "/home/jenkins/.m2"
RUN set -ex; \
    wget https://raw.githubusercontent.com/capralifecycle/buildtools-snippets/${BRANCH}/tools/maven-3/install.sh -O /tmp/script.sh; \
    sh /tmp/script.sh; \
    rm /tmp/script.sh; \
    mvn -version
