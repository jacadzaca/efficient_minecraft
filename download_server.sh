if [[ $MINECRAFT_VERSION == 'latest' ]]; then
    #ask the server what's the newest version
    MINECRAFT_VERSION=$(curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.latest | .release')
fi

if [[ $TYPE == 'vanilla' ]]; then
    #download the server.jar
    curl https://launchermeta.mojang.com/mc/game/version_manifest.json | \
        jq '.versions[] | select(.id == "'"$MINECRAFT_VERSION"'") | .url' | \
        xargs curl | \
        jq '.downloads.server.url' | \
        xargs curl > server.jar
fi

if [[ $TYPE == 'forge' ]]; then
    #downloads a forge server
    #this section requires the $FORGE_VERSION variable to be specifed
    FORGE_URL='http://files.minecraftforge.net/maven/net/minecraftforge/forge/'"$MINECRAFT_VERSION"''-"$FORGE_VERSION"'/forge-'"$MINECRAFT_VERSION"'-'"$FORGE_VERSION"'-installer.jar'
    FORGE_INSTALLER_JAR='forge-'"$MINECRAFT_VERSION"'-'"$FORGE_VERSION"'-installer.jar'
    FORGE_EXE='forge-'"$MINECRAFT_VERSION"'-'"$FORGE_VERSION"'-universal.jar'
    if [[ ${MINECRAFT_VERSION//./} -gt 1131 ]]; then
        FORGE_EXE='forge-'"$MINECRAFT_VERSION"'-'"$FORGE_VERSION"'.jar'
    fi
    echo $FORGE_EXE
    curl -o $FORGE_INSTALLER_JAR $FORGE_URL && \
        java -jar $FORGE_INSTALLER_JAR --installServer && \
        rm $FORGE_INSTALLER_JAR $FORGE_INSTALLER_JAR.log && \
        mv $FORGE_EXE server.jar
fi

if [[ $TYPE == 'spigot' ]]; then
    #downloads a spigot server
    BUILD_TOOLS_URL="https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
    BUILD_TOOLS_JAR="BuildTools.jar"
    apk update --no-cache && apk add --no-cache git
    curl $BUILD_TOOLS_URL -o $BUILD_TOOLS_JAR && \
        java -jar $BUILD_TOOLS_JAR --rev $MINECRAFT_VERSION && \
        rm $BUILD_TOOLS_JAR && \
        mv spigot-*.jar server.jar
    apk del git
fi
