#!/bin/sh
while getopts "v:t:f:" opt; do
    case $opt in
        v )
            VERSION=$OPTARG
            ;;
        t )
            TYPE=$OPTARG
            ;;
        f )
            FORGE_VERSION=$OPTARG
            ;;
        * )
            echo "Usage: build_image.sh [-v] (version) [-t] (type) [-f] (forge version)"
            echo "Example: build_image.sh -v 1.12.2 -t vanilla"
            exit 1
            ;;
    esac
done

#set default values...
[ -z $TYPE ] \
    && TYPE=vanilla \

[ -z $VERSION ] \
    && VERSION=$(curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.latest | .release')

IMAGE_TAG="minecraft_server:$VERSION-$TYPE"
docker build --tag $IMAGE_TAG \
             --build-arg MINECRAFT_VERSION=$VERSION \
             --build-arg TYPE=$TYPE \
             --build-arg FORGE_VERSION=$FORGE_VERSION https://raw.githubusercontent.com/jacadzaca/efficient_minecraft/master/Dockerfile
echo $IMAGE_TAG > .last_tag