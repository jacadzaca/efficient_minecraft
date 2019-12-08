

# About

This docker image utilizes the OpenJ9 virtual machine to provide a resource-efficient Minecraft server.

##  Usage
To start a  Minecraft server, for the first time, just build the image and make docker run it, using:
```bash
docker-compose build && docker-compose up -d
```
## Configuration

All the config files that are used by the server are located in the settings/ directory. You can edit them just like you would edit any other file.

## License
[MIT](https://choosealicense.com/licenses/mit/)