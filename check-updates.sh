#!/bin/bash
set -eu -o pipefail

declare -i updates=0

# Run with --modify to do in-place modification as well.
execute=false
if [ "${1:-}" = "--modify" ]; then
  execute=true
fi

verify_version_newer_or_latest() {
  current=$1
  candidate=$2

  latest=$(echo -e "$current\n$candidate" | sort -V | tail -n 1)
  if [ "$latest" != "$candidate" ]; then
    >&2 echo "Expected $candidate to be newer or same as $latest"
    exit 1
  fi
}

extract_var() {
  file=$1
  name=$2

  sed -n "s/^\($name=\)\(.\+\)/\2/p" "$file"
}

replace_var() {
  file=$1
  name=$2
  value=$3

  sed -i "s/^\($name=\)\(.\+\)/\1$value/" "$file"
}

check_sonar_scanner() {
  echo "Checking sonar-scanner"

  current=$(extract_var tools/sonar-scanner/install-alpine.sh SONAR_SCANNER_VERSION)
  candidate=$(curl -s https://api.github.com/repos/SonarSource/sonar-scanner-cli/tags | jq -r '.[0].name')

  # Verify valid tag as version.
  if ! echo "$candidate" | grep -q '^\([0-9]\+\.\)\{3\}[0-9]\+$'; then
    >&2 echo "Tag $candidate unexpected"
    exit 1
  fi

  verify_version_newer_or_latest "$current" "$candidate"

  if [ "$current" != "$candidate" ]; then
    echo "Update available: sonar-scanner $current -> $candidate"
    if [ "$execute" = true ]; then
      replace_var tools/sonar-scanner/install-alpine.sh SONAR_SCANNER_VERSION "$candidate"
    fi
    updates+=1
  fi
}

check_sonar_scanner

if [ $updates -eq 0 ]; then
  echo "No updates found!"
elif ! [ "$execute" = true ]; then
  echo "To execute the chages:"
  echo "$0 --modify"
fi
