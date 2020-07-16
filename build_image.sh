#!/bin/sh
while getopts "v:t:f:" opt; do
    case $opt in
        v )
            [ -z $OPTARG ] \
                && VERSION="" \
                || VERSION=$OPTARG
            ;;
        t )
            [ -z $OPTARG ] \
                && TYPE="" \
                || TYPE=$OPTARG
            ;;
        f )
            [ -z $OPTARG ] \
                && FORGE_VERSION="" \
                || FORGE_VERSION=$OPTARG
            ;;
        * )
            echo "Usage: build.sh [-v] (version) [-t] (type) [-f] (forge version)"
            echo "Example: build.sh -v 1.12.2 -t vanilla"
            exit 1
            ;;
    esac
done

#set default values...
[ -z $TYPE ] \
    && TYPE=vanilla \

[ -z $VERSION ] \
    && VERSION=$(curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.latest | .release')

docker build --tag "minecraft_server:$VERSION-$TYPE" \
             --build-arg MINECRAFT_VERSION=$VERSION \
             --build-arg TYPE=$TYPE \
             --build-arg FORGE_VERSION=$FORGE_VERSION https://raw.githubusercontent.com/jacadzaca/efficient_minecraft/master/Dockerfile
