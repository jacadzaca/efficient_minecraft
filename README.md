


# About

This docker image utilizes the OpenJ9 virtual machine to provide a resource-efficient Minecraft server  
Requires [docker](https://get.docker.com/)

##  Usage
Create a directory for server files and cd into it:
```bash
mkdir minecraft_server && cd minecraft_server
```
Download create_server file and make it an executable:
```bash
curl -o create_server https://raw.githubusercontent.com/jacadzaca/efficient_minecraft/master/create_server.sh && chmod +x create_server
```
To create all the needed files, and to start a latest-version Minecraft server, run:
```bash
./create_server
```
...you can also name your container by supplying an -n argument:
```bash
./create_server -n some-name
```
To extract the container's/server's IP address use:
```bash
docker inspect -f "{{ .NetworkSettings.IPAddress }}" <containerNameOrId>
```
The server is now up and running. You can now safely remove the script files:
```bash
rm build_image.sh create_*
```
## Configuration

All the config files that are used by the server are located in the settings/ directory, you can edit them just like you would edit any other file. After each set of changes, restart the server

By default, the container's memory limit is set to 2GB. You can specify the maximum when creating a server:
```bash
./create_server -m {NUMBER}GB
```
...or you can use the create_container.sh script:
```bash
./create_container -m {NUMBER}GB
```

When not specifed, the script downloads the latest version of a Minecraft server. You can choose what version you prefer, by supplying the version during the server creation process:
```bash
./create_server -v 1.12.2
```
### Types
You can specify what kind of server you would like to be created by supplying an -t argument. If no -t value is specifed, a Vanilla server will be created.

#### Forge Server
In order to create a Minecraft Forge server, you must specify the type, the Forge version and the Minecraft version coresponding to the Forge's version:
```bash
./create_server -t forge -v 1.12.2 -f 14.23.5.2854
```
#### Spigot Server
In order to create a Spigot server, you must only specify the type:
```bash
./create_server -t spigot
```

## build_image and create_container scripts usages
```bash
create_container.sh [-m] (max memory) [-n] (container name) [-i] (docker image tag) [-t] (type)
build_image.sh [-v] (version) [-t] (type) [-f] (forge version)
```

## RCON

You can enable RCON in the settings/server.properties file. By default, the container's 25575 port is exposed.

## License
[MIT](https://choosealicense.com/licenses/mit/)  
By using this program you agree to the Minecraft EULA
