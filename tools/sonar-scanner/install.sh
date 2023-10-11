#!/bin/sh
set -eux

# renovate: datasource=github-releases depName=SonarSource/sonar-scanner-cli versioning=maven
SONAR_SCANNER_VERSION=4.6.1.2450

if [ -e /etc/alpine-release ]; then
  # Alpine cannot use the bundled java version, so we install java if not available.
  if ! which java >/dev/null; then
    apk add --no-cache openjdk11-jre
  fi
else
  if ! which java >/dev/null; then
    # Use the version with java bundled.
    SONAR_SCANNER_VERSION=${SONAR_SCANNER_VERSION}-linux
  fi
fi

# key obtained from https://github.com/SonarSource/docker-sonarqube/blob/0cd256fd168ee4f729bc87b6259c7d9eb1349400/10/enterprise/Dockerfile#L36
for key in \
  "679F1EE92B19609DE816FDE81DB198F93525EC1A" \
; do
  gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key"
done

[ ! -d /opt ] && mkdir -p /opt
wget -O /opt/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip
wget -O /opt/sonar-scanner.asc https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip.asc
wget -O /opt/sonar-scanner.sha256 https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip.sha256
gpg --verify /opt/sonar-scanner.asc /opt/sonar-scanner.zip
echo "$(cat /opt/sonar-scanner.sha256)  /opt/sonar-scanner.zip" | sha256sum -c -
unzip /opt/sonar-scanner.zip -d /opt
rm /opt/sonar-scanner.zip
rm /opt/sonar-scanner.asc
rm /opt/sonar-scanner.sha256
ln -s /opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/bin/sonar-scanner
