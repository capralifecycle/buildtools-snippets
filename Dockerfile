FROM alpine
RUN apk add --no-cache \
      bash \
      coreutils \
      curl \
      jq
