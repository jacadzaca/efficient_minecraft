


# About

This docker image utilizes the OpenJ9 virtual machine to provide a resource-efficient Minecraft server

##  Usage
Create a directory for server files and cd into it:
```bash
mkdir minecraft_server && cd minecraft_server
```
Download create_server file and make it executable:
```bash
curl -o create_server https://raw.githubusercontent.com/jacadzaca/efficient_minecraft/master/create_server.sh && chmod +x create_server
```
To create all needed files and start a latest-version Minecraft server, run:
```bash
./create_server
```
To extract the server's IP address use:
```bash
docker inspect -f "{{ .NetworkSettings.IPAddress }}" <containerNameOrId>
```
## Configuration

All the config files that are used by the server are located in the settings/ directory, you can edit them just like you would edit any other file. After each change, restart the server

By the default, the container's memory limit is set to 2G, you can specify maximal when building a server:
```bash
./create_server -m {NUMBER}GB
```
...or you can use the create_container.sh script:
```bash
./create_container -m {NUMBER}GB
```

When not specifed, the image downloads the latest version of a Minecraft server. You can choose what version you prefer by supplying the version during the server creation process:
```bash
./create_server -v 1.12.2
```
...or you can use the build_image.sh script:
```bash
./build_image -v 1.12.2
```
### Types
You can specify what kind of server you would like to be created by supplying the -t argument.
As of now, the supported types are: vanilla, forge and spigot

#### Forge Server
In order to create a Minecraft Forge server, you must specify the type, Forge version and a Minecraft version coresponding to the Forge:
```bash
./create_server -t forge -v 1.12.2 -f 14.23.5.2854
```  
#### Spigot Server
In order to create a Spigot server, you must specify the type:
```bash
./create_server -t spigot
```  
It might take a while to build

## RCON

You can enable RCON in the settings/server.properties file, the 25575 port is exposed

## License
[MIT](https://choosealicense.com/licenses/mit/)  
By using this program you agree to the Minecraft EULA