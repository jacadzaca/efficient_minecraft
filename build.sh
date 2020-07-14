#!/bin/sh
while getopts ":v:t:tag:vForge:" opt; do
    case $opt in
        v )
            VERSION=$OPTARG
            ;;
        t )
            TYPE=$OPTARG
            ;;
        tag )
            IMAGE_TAG=$OPTARG
            ;;
        vForge )
            FORGE_VERSION=$OPTARG
            ;;
        * )
            echo "Usage: build.sh [-v] (version) [-t] (type) [-tag] (docker iamge tag) [-vForge] (forge version)"
            echo "Example: build.sh -v 1.12.2 -t forge -tag minecraft_server_1.12.2_forge_test"
            exit 126
            ;;
    esac
done

#set default values...
[ -z $TYPE ] \
    && TYPE=vanilla \

[ -z $VERSION ] \
    && VERSION=$(curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.latest | .release')

[ -z $IMAGE_TAG ] \
    && IMAGE_TAG=minecraft_server:$VERSION-$TYPE

docker build --tag $IMAGE_TAG --build-arg MINECRAFT_VERSION=$VERSION --build-arg TYPE=$TYPE --build-arg FORGE_VERSION=$FORGE_VERSION .