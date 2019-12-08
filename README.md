

# About

This docker image utilizes the OpenJ9 virtual machine to provide a resource-efficient Minecraft server

##  Usage
To start a  Minecraft server, for the first time, just build the image and make docker run it, using:
```bash
docker-compose build && docker-compose up -d
```
## Configuration

All the config files that are used by the server are located in the settings/ directory. You can edit them just like you would edit any other file

By the default, the container's memory limit is set to 2G 

The pre-selected Minecraft version is 1.12, you can choose what version you prefer by editing the Dockerfile or supplying the version during the build process:
```bash
docker-compose build --build-arg MINECRAFT_VERSION={PREFFERED_VERSION}
``` 

## RCON

RCON is allowed by the default, it's running on port 25575

## License
[MIT](https://choosealicense.com/licenses/mit/)