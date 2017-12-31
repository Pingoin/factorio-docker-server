FROM frolvlad/alpine-glibc:latest

MAINTAINER https://github.com/Pingoin/factorio_server_docker

ARG USER=factorio
ARG GROUP=factorio
ARG PUID=1000
ARG PGID=1000

ENV PORT=34197 \
    RCON_PORT=27015 \
    VERSION=0.16.11

RUN mkdir -p /factorio && \
    apk add --update --no-cache pwgen && \
    apk add --update --no-cache --virtual .build-deps curl && \
    apk del .build-deps && \
    addgroup -g $PGID -S $GROUP && \
    adduser -u $PUID -G $USER -s /bin/sh -SDH $GROUP && \
    chown -R $USER:$GROUP /factorio

VOLUME /factorio

EXPOSE $PORT/udp $RCON_PORT/tcp

COPY ./docker-entrypoint.sh /

USER $USER

ENTRYPOINT /docker-entrypoint.sh $VERSION
