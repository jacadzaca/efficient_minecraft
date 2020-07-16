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

# no need to set default values, it is done in build_image.sh and create_container.sh
./build_image.sh -v $VERSION -t $TYPE -f $FORGE_VERSION \
    && ./create_container.sh -i "minecraft_server:$VERSION-$TYPE" -n $NAME -m $MAX_MEMORY