FROM adoptopenjdk/openjdk8-openj9:alpine-slim

ARG MINECRAFT_VERSION=latest
ARG TYPE=vanilla
ARG FORGE_VERSION=None

WORKDIR /minecraft

ENTRYPOINT ["entrypoint.sh"]
COPY entrypoint.sh /usr/local/bin

EXPOSE 25565 25575

COPY download_server.sh .
RUN apk update --no-cache && apk add --no-cache \
        curl \
        jq \
    && ./download_server.sh \
    && rm download_server.sh \
    && apk del \
        curl \
        jq