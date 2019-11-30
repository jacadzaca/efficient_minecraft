FROM adoptopenjdk/openjdk8-openj9:alpine-slim

WORKDIR /minecraft
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 25565

ARG MINECRAFT_VERSION=1.12
ARG MINECRAFT_JAR=minecraft_server.${MINECRAFT_VERSION}.jar
ARG MINECRAFT_URL=https://s3.amazonaws.com/Minecraft.Download/versions/${MINECRAFT_VERSION}/${MINECRAFT_JAR}

RUN apk --no-cache add wget
RUN wget ${MINECRAFT_URL}

COPY settings /minecraft
COPY entrypoint.sh /usr/local/bin