# Notice

This Dockerfile is only for x86_64 architecture only. If you're interested in ARM port, have a look at [this fork](https://github.com/synopsis8/dockerfiles)

# Configuration

Create needed directories with

```sh
mkdir -p ./amule/conf
mkdir -p ./amule/tmp
mkdir -p ./amule/incoming
```

# Usage

Just run the container with the following command lines (replace brackets with the values you want to use) :

## Start from scratch

If you don't have any existing amule configuration, you can specify a custom password for GUI and / or WebUI using adequate environment variables.

- To use amule GUI as interface :

```sh
docker run -p 4712:4712 -p 4662:4662 -p 4672:4672/udp \
    -e PUID=[wanted_uid] -e PGID=[wanted_gid] \
    -e GUI_PWD=[wanted_password_for_gui] \
    -v ./amule/conf:/home/amule/.aMule -v ./amule/incoming:/incoming -v ./amule/tmp:/temp tchabaud/amule
```

- To use web ui from a browser :

```sh
docker run -p 4711:4711 -p 4662:4662 -p 4672:4672/udp \
    -e PUID=[wanted_uid] -e PGID=[wanted_gid] \
    -e WEBUI_PWD=[wanted_password_for_web_interface] \
    -v ./amule/conf:/home/amule/.aMule -v ./amule/incoming:/incoming -v ./amule/tmp:/temp tchabaud/amule
```
## Using an existing amule configuration

Just mount existing directory as a volume :

```sh
docker run -p 4711:4711 -p 4662:4662 -p 4672:4672/udp \
    -e PUID=[wanted_uid] -e PGID=[wanted_gid] \
    -v ~/.aMule:/home/amule/.aMule -v ~/.aMule/Incoming:/incoming -v ~/.aMule/Temp:/temp tchabaud/amule
```

Then point your browser to http://localhost:4711

## Web UI theming

If you don't like default amule web ui, you can switch [to this nice bootstrap based web theme](https://github.com/MatteoRagni/AmuleWebUI-Reloaded) by setting the environment variable _WEBUI_TEMPLATE_ to _AmuleWebUI-Reloaded_

*Example* :

```sh
docker run -p 4711:4711 -p 4662:4662 -p 4672:4672/udp \
    -e PUID=[wanted_uid] \
    -e PGID=[wanted_gid] \
    -e WEBUI_TEMPLATE="AmuleWebUI-Reloaded" \
    -v ~/.aMule:/home/amule/.aMule \
    -v ~/.aMule/Incoming:/incoming \
    -v ~/.aMule/Temp:/temp tchabaud/amule
```
