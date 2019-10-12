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

check() {
  file=$1
  name=$2
  candidate=$3

  current=$(extract_var $file $name)

  verify_version_newer_or_latest "$current" "$candidate"

  if [ "$current" != "$candidate" ]; then
    echo "Update available: $file $current -> $candidate"
    if [ "$execute" = true ]; then
      replace_var $file $name "$candidate"
    fi
    updates+=1
  fi
}

get_docker_versions() {
  # Copied from https://github.com/docker-library/docker/blob/cbb0ee05d8be7b73d6b482c4a602be137e108f77/update.sh
  git ls-remote --tags https://github.com/docker/docker-ce.git \
    | cut -d$'\t' -f2 \
    | grep '^refs/tags/v[0-9].*$' \
    | sed 's!^refs/tags/v!!; s!\^{}$!!' \
    | sort -u \
    | gawk '
      { data[lines++] = $0 }
      # "beta" sorts lower than "tp" even though "beta" is a more preferred release, so we need to explicitly adjust the sorting order for RCs
      # also, "18.09.0-ce-beta1" vs "18.09.0-beta3"
      function docker_version_compare(i1, v1, i2, v2, l, r) {
        l = v1; gsub(/-ce/, "", l); gsub(/-tp/, "-alpha", l)
        r = v2; gsub(/-ce/, "", r); gsub(/-tp/, "-alpha", r)
        patsplit(l, ltemp, /[^.-]+/)
        patsplit(r, rtemp, /[^.-]+/)
        for (i = 0; i < length(ltemp) && i < length(rtemp); ++i) {
          if (ltemp[i] < rtemp[i]) {
            return -1
          }
          if (ltemp[i] > rtemp[i]) {
            return 1
          }
        }
        return 0
      }
      END {
        asort(data, result, "docker_version_compare")
        for (i in result) {
          print result[i]
        }
      }
    '
}

check_docker() {
  echo "Checking docker"
  docker_versions="$(get_docker_versions)"
  candidate=$(echo "$docker_versions" | grep '^[0-9\.]\+$' | tail -n 1)

  check tools/docker/install-alpine.sh DOCKER_VERSION "$candidate"
  check tools/docker/install.sh DOCKER_VERSION "$candidate"
}

check_maven_3() {
  echo "Checking maven-3"

  candidate=$(
    git ls-remote --tags https://github.com/apache/maven.git \
      | cut -d$'\t' -f2 \
      | grep '^refs/tags/maven-[0-9\.]\+$' \
      | sed 's!^refs/tags/maven-!!; s!\^{}$!!' \
      | sort -V \
      | tail -n 1
  )

  p=$updates
  check tools/maven-3/install.sh MAVEN_VERSION "$candidate"

  # Also update the SHA512.
  if [ $p -ne $updates ] && [ "$execute" = true ]; then
    sha=$(
      curl -sL https://www.apache.org/dist/maven/maven-3/$candidate/binaries/apache-maven-$candidate-bin.tar.gz.sha512 \
        | awk '{ print $1 }'
    )
    replace_var tools/maven-3/install.sh SHA "$sha"
  fi
}

check_sonar_scanner() {
  echo "Checking sonar-scanner"
  candidate=$(curl -s https://api.github.com/repos/SonarSource/sonar-scanner-cli/tags | jq -r '.[0].name')

  # Verify valid tag as version.
  if ! echo "$candidate" | grep -q '^\([0-9]\+\.\)\{3\}[0-9]\+$'; then
    >&2 echo "Tag $candidate unexpected"
    exit 1
  fi

  check tools/sonar-scanner/install-alpine.sh SONAR_SCANNER_VERSION "$candidate"
  check tools/sonar-scanner/install.sh SONAR_SCANNER_VERSION "$candidate"
}

check_docker
check_maven_3
check_sonar_scanner

if [ $updates -eq 0 ]; then
  echo "No updates found!"
elif ! [ "$execute" = true ]; then
  echo "To execute the chages:"
  echo "$0 --modify"
fi
