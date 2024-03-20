#!/bin/sh
set -eux

# Java must be installed separately.

# reference: https://github.com/carlossg/docker-maven/blob/966c1657b1629cdb547692ac8e48b491a9961892/jdk-11/Dockerfile

# renovate: datasource=github-releases depName=apache/maven extractVersion=^maven-(?<version>.*)$
MAVEN_VERSION=3.9.6
SHA=706f01b20dec0305a822ab614d51f32b07ee11d0218175e55450242e49d2156386483b506b3a4e8a03ac8611bae96395fd5eec15f50d3013d5deed6d1ee18224
# NOTE: We previously used https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries as the URL,
# but only the two latest minor versions are available there
BASE_URL=https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries

mkdir -p /usr/share/maven /usr/share/maven/ref
wget -O /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz
echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c -
tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1
rm -f /tmp/apache-maven.tar.gz
ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
mvn -version
