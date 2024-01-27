FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b
RUN apk add --no-cache \
      bash \
      coreutils \
      curl \
      git \
      gawk \
      jq
