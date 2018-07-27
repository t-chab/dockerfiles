FROM alpine:latest

LABEL maintainer="docker@chabs.name"

ENV GITHUB_ROOT="https://github.com/tchabaud/lets-encrypt-gandi"
ENV WORKDIR="/data"

ADD "${GITHUB_ROOT}/raw/master/run.sh" /opt/run.sh
ADD "${GITHUB_ROOT}/raw/master/hook.sh" /opt/hook.sh
ADD "https://github.com/lukas2511/dehydrated/raw/master/dehydrated" /opt/dehydrated

RUN apk --update add bash curl openssl diffutils ca-certificates \
    && chmod +x /opt/*

WORKDIR /opt

VOLUME [ "/data" ]

ENTRYPOINT [ "/opt/run.sh" ]
