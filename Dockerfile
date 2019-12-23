FROM adoptopenjdk/openjdk8-openj9:alpine-slim

ARG MINECRAFT_VERSION=1.12

WORKDIR /minecraft
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 25565 25575

RUN apk update --no-cache && apk add --no-cache \
        curl \
        jq \
    && curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq '. | .versions[] | select(.id == "'"$MINECRAFT_VERSION"'") | .url' | xargs curl | jq '.downloads.server.url' | xargs curl > server.jar \
    && apk del \
        curl \
        jq

COPY entrypoint.sh /usr/local/bin