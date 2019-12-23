if [[ $MINECRAFT_VERSION == 'latest' ]]; then
    #ask the server what's the newest version
    MINECRAFT_VERSION=$(curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.latest | .release')
fi
#download the server.jar
curl https://launchermeta.mojang.com/mc/game/version_manifest.json | \
    jq '.versions[] | select(.id == "'"$MINECRAFT_VERSION"'") | .url' | \
    xargs curl | \
    jq '.downloads.server.url' | \
    xargs curl > server.jar
