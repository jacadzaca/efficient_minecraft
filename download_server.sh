#!/bin/sh
[ -z "$MINECRAFT_VERSION" ] \
    && echo "No Minecraft version specifed!" \
    && echo "Usage: build_image.sh [-v] (game version)" \
    && exit 1

case $TYPE in
    vanilla )
        curl https://launchermeta.mojang.com/mc/game/version_manifest.json | \
            jq '.versions[] | select(.id == "'"$MINECRAFT_VERSION"'") | .url' | \
            xargs curl | \
            jq '.downloads.server.url' | \
            xargs curl -o server.jar
        ;;
    forge )
        #this section requires the $FORGE_VERSION variable to be specifed
        [ -z "$FORGE_VERSION" ] \
            && echo "Cannot build an forge image, forge version missing" \
            && echo "Usage: build_image.sh [-f] (forge version)"
        FORGE_URL='http://files.minecraftforge.net/maven/net/minecraftforge/forge/'"$MINECRAFT_VERSION"''-"$FORGE_VERSION"'/forge-'"$MINECRAFT_VERSION"'-'"$FORGE_VERSION"'-installer.jar'
        FORGE_INSTALLER_JAR='forge-'"$MINECRAFT_VERSION"'-'"$FORGE_VERSION"'-installer.jar'
        curl -o "$FORGE_INSTALLER_JAR $FORGE_URL" && \
            java -jar "$FORGE_INSTALLER_JAR" --installServer && \
            rm "$FORGE_INSTALLER_JAR" "$FORGE_INSTALLER_JAR.log" && \
            mv forge-*.jar server.jar
        ;;
    spigot )
        BUILD_TOOLS_URL="https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
        BUILD_TOOLS_JAR="BuildTools.jar"
        apk update --no-cache && apk add --no-cache git
        curl "$BUILD_TOOLS_URL" -o "$BUILD_TOOLS_JAR" && \
            java -jar "$BUILD_TOOLS_JAR" --rev "$MINECRAFT_VERSION" && \
            rm $BUILD_TOOLS_JAR && \
            mv spigot-*.jar server.jar
        apk del git
        ;;
esac
