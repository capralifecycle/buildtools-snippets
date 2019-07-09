#!/bin/sh
set -eux

SONAR_SCANNER_VERSION=4.0.0.1744

echo "########################################################################"
echo "##                                                                    ##"
echo "##  You are using the deprecated install-alpine.sh for sonar-scanner  ##"
echo "##  which should be changed to install.sh                             ##"
echo "##                                                                    ##"
echo "########################################################################"

# Only install java if not already present (to avoid conflicting Java version)
if ! which java >/dev/null; then
  apk add --no-cache openjdk8-jre
fi

[ ! -d /opt ] && mkdir -p /opt
wget -O /opt/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip
unzip /opt/sonar-scanner.zip -d /opt
rm /opt/sonar-scanner.zip
ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/bin/sonar-scanner
