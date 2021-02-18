FROM alpine@sha256:a75afd8b57e7f34e4dad8d65e2c7ba2e1975c795ce1ee22fa34f8cf46f96a3be
RUN apk add --no-cache \
      bash \
      coreutils \
      curl \
      git \
      gawk \
      jq
