#!/bin/sh
#create missing files...
(mkdir settings/ > /dev/null 2>&1) \
    && (echo "[]" > settings/ops.json) \
    && touch settings/server.properties \
    && (echo "[]" > settings/whitelist.json) \
    && (echo "[]" > settings/banned-ips.json) \
    && (echo "eula=true" > settings/eula.txt) \
    && (echo "[]" > settings/banned-players.json) \

mkdir world/ > /dev/null 2>&1
mkdir logs/ > /dev/null 2>&1
mkdir crash-reports/ > /dev/null 2>&1

#must be the same as settings/server.properties.level-name...
LEVEL_NAME=world

while getopts ":v:t:m:n:tag:" opt; do
    case $opt in
        v )
            VERSION=$OPTARG
            ;;
        t )
            TYPE=$OPTARG
            ;;
        m )
            MAX_MEMORY=$OPTARG
            ;;
        n )
            NAME=$OPTARG
            ;;
        tag )
            IMAGE_TAG=$OPTARG
            ;;
        * )
            echo "Usage: create_server [-v] (version) [-t] (type) [-m] (max memory) [-n] (container name) [-tag] (docker image to use)"
            echo "Example: create_server -v 1.12.2 -t forge -m 3GB -n asdf"
            exit 1
            ;;
    esac
done

#set default values...
[ -z $TYPE ] \
    && TYPE=vanilla \

[ -z $VERSION ] \
    && VERSION=$(curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.latest | .release')

[ -z $MAX_MEMORY ] \
    && MAX_MEMORY=2GB

[ -z $NAME ] \
    && ID=$(date +%N); \
       NAME=minecraft_server_$VERSION_$TYPE_$ID

[ -z $IMAGE_TAG ] \
    && IMAGE_TAG=minecraft_server:$VERSION-$TYPE


#create generic command...
CMD="docker run -d \
    --name $NAME \
    --memory $MAX_MEMORY \
    -p 25565:25565
    -p 25575:25575
    --mount type=bind,source=$PWD/logs,target=/minecraft/logs \
    --mount type=bind,source=$PWD/world,target=/minecraft/$LEVEL_NAME \
    --mount type=bind,source=$PWD/settings/eula.txt,target=/minecraft/eula.txt \
    --mount type=bind,source=$PWD/settings/ops.json,target=/minecraft/ops.json \
    --mount type=bind,source=$PWD/crash-reports/,target=/minecraft/crash-reports \
    --mount type=bind,source=$PWD/settings/whitelist.json,target=/minecraft/whitelist.json \
    --mount type=bind,source=$PWD/settings/banned-ips.json,target=/minecraft/banned-ips.json \
    --mount type=bind,source=$PWD/settings/server.properties,target=/minecraft/server.properties \
    --mount type=bind,source=$PWD/settings/banned-players.json,target=/minecraft/banned-players.json"

#add the specific mounts...
case $TYPE in
    vanilla )
        ;;
    forge )
        CMD="$CMD \
            --mount type=bind,source=$PWD/mods,target=/minecraft/mods \
            --mount type=bind,source=$PWD/settings,target=/minecraft/config"
        mkdir mods/ > /dev/null 2>&1
        ;;
    spigot )
        CMD="$CMD \
            --mount type=bind,source=$PWD/settings/bukkit.yml,target=/minecraft/bukkit.yml \
            --mount type=bind,source=$PWD/settings/spigot.yml,target=/minecraft/spigot.yml \
            --mount type=bind,source=$PWD/settings/commands.yml,target=/minecraft/commands.yml \
            --mount type=bind,source=$PWD/plugins,target=/minecraft/plugins"
        touch settings/bukkit.yml
        touch settings/spigot.yml
        touch settings/commands.yml
        mkdir plugins/ > /dev/null 2>&1
        ;;
    * ) 
        echo "$TYPE is an unsupported server type!"
        exit 1
        ;;
esac

#start the container...
$CMD $IMAGE_TAG \
    && echo "In order to use the server, edit the settings/eula.txt and run 'docker start $NAME'" \
