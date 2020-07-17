#!/bin/sh
while getopts "v:t:f:n:m:" opt; do
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
        n )
            NAME=$OPTARG
            ;;
        m )
            MAX_MEMORY=$OPTARG
            ;;
        * )
            echo "Usage: create_server.sh [-v] (version) [-t] (type) [-f] (forge version) [-n] (create docker container with this name) [-m] (max memory)"
            echo "Example: build.sh -v 1.12.2 -t vanilla -n mc_server -m 3GB"
            exit 1
            ;;
    esac
done

curl -o build_image.sh https://raw.githubusercontent.com/jacadzaca/efficient_minecraft/master/build_image.sh \
    && chmod +x build_image.sh
curl -o create_container.sh https://raw.githubusercontent.com/jacadzaca/efficient_minecraft/master/create_container.sh \
    && chmod +x create_container.sh

BUILD_CMD="./build_image.sh"

[ ! -z $TYPE ] && BUILD_CMD="$BUILD_CMD -t $TYPE"
[ ! -z $VERSION ] && BUILD_CMD="$BUILD_CMD -v $VERSION"
[ ! -z $FORGE_VERSION ] && BUILD_CMD="$BUILD_CMD -f $FORGE_VERSION"

CREATE_CONTAINER_CMD="./create_container.sh"
[ ! -z $NAME ] && CREATE_CONTAINER_CMD="$CREATE_CONTAINER_CMD -n $NAME"
[ ! -z $MAX_MEMORY ] && CREATE_CONTAINER_CMD="$CREATE_CONTAINER_CMD -m $MAX_MEMORY"


$BUILD_CMD && $CREATE_CONTAINER_CMD -i "$(cat .last_tag)"
