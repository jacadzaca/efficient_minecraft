


# About

This docker image utilizes the OpenJ9 virtual machine to provide a resource-efficient Minecraft server

##  Usage
To start a latest-version Minecraft server, just build the image and start a container:
```bash
docker-compose build --force-rm && docker-compose up -d
```
## Configuration

All the config files that are used by the server are located in the settings/ directory. You can edit them just like you would edit any other file

By the default, the container's memory limit is set to 2G 

When not specifed, the image downloads the latest version of a Minecraft server. You can choose what version you prefer by editing the Dockerfile or supplying the version during the build process:
```bash
docker-compose build --build-arg MINECRAFT_VERSION=PREFFERED_VERSION
``` 
### Types
You can specify what kind of server you would like to be created by changing the TYPE variable.
As of now, there are two possible server types: vanilla and forge

#### Forge Server
In order to create a Minecraft Forge server, you must specify the type, Forge version and a Minecraft version coresponding to the Forge:
```bash
docker-compose build --build-arg TYPE=forge --build-arg MINECRAFT_VERSION=1.14.4 --build-arg FORGE_VERSION=28.1.0
```  

## RCON

RCON is allowed by the default, it's running on port 25575

## License
[MIT](https://choosealicense.com/licenses/mit/)
By using this program you agree to the Minecraft EULA