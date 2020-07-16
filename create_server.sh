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

# no need to set default values, it is done in build_image.sh and create_container.sh
./build_image.sh -v $VERSION -t $TYPE -f $FORGE_VERSION \
    && ./create_container.sh -i "minecraft_server:$VERSION-$TYPE" -n $NAME -m $MAX_MEMORY