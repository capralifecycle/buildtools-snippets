FROM alpine

COPY tools/sonar-scanner/install-alpine.sh /install-alpine.sh

RUN /install-alpine.sh
