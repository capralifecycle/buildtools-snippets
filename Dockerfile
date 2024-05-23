FROM alpine@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd
RUN apk add --no-cache \
      bash \
      coreutils \
      curl \
      git \
      gawk \
      jq
