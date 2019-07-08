#!/bin/sh
set -eux

# Java must be installed separately.

# reference: https://github.com/carlossg/docker-maven/blob/966c1657b1629cdb547692ac8e48b491a9961892/jdk-11/Dockerfile

MAVEN_VERSION=3.6.1
SHA=b4880fb7a3d81edd190a029440cdf17f308621af68475a4fe976296e71ff4a4b546dd6d8a58aaafba334d309cc11e638c52808a4b0e818fc0fd544226d952544
BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

mkdir -p /usr/share/maven /usr/share/maven/ref
wget -O /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz
echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c -
tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1
rm -f /tmp/apache-maven.tar.gz
ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
mvn -version
