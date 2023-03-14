FROM alpine@sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517
RUN apk add --no-cache \
      bash \
      coreutils \
      curl \
      git \
      gawk \
      jq
