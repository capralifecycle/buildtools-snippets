#!/bin/sh
set -eux

# See check-updates.sh.
SONAR_SCANNER_VERSION=4.3.0.2102

if [ -e /etc/alpine-release ]; then
  # Alpine cannot use the bundled java version, so we install java if not available.
  if ! which java >/dev/null; then
    apk add --no-cache openjdk8-jre
  fi
else
  if ! which java >/dev/null; then
    # Use the version with java bundled.
    SONAR_SCANNER_VERSION=${SONAR_SCANNER_VERSION}-linux
  fi
fi

[ ! -d /opt ] && mkdir -p /opt
wget -O /opt/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip
unzip /opt/sonar-scanner.zip -d /opt
rm /opt/sonar-scanner.zip
ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/bin/sonar-scanner
