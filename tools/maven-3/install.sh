#!/bin/sh
set -eux

# Java must be installed separately.

# reference: https://github.com/carlossg/docker-maven/blob/966c1657b1629cdb547692ac8e48b491a9961892/jdk-11/Dockerfile

# renovate: datasource=github-releases depName=apache/maven extractVersion=^maven-(?<version>.*)$
MAVEN_VERSION=3.9.6
SHA=4810523ba025104106567d8a15a8aa19db35068c8c8be19e30b219a1d7e83bcab96124bf86dc424b1cd3c5edba25d69ec0b31751c136f88975d15406cab3842b
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
