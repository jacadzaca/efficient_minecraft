FROM adoptopenjdk/openjdk8-openj9:alpine-slim

ARG MINECRAFT_VERSION=''
ARG TYPE=vanilla
ARG FORGE_VERSION=''

WORKDIR /minecraft

EXPOSE 25565 25575

ENTRYPOINT ["entrypoint"]

RUN apk update --no-cache \
    && apk add --no-cache curl jq \
    && curl -o /usr/local/bin/entrypoint https://raw.githubusercontent.com/jacadzaca/efficient_minecraft/master/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint \
    && curl -o download_server.sh https://raw.githubusercontent.com/jacadzaca/efficient_minecraft/master/download_server.sh \
    && chmod +x download_server.sh \
    && ./download_server.sh \
    && rm download_server.sh \
    && apk del curl jq
