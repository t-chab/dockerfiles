# docker-deluge
Simple Dockerfile to build deluge containers

# Usage

For first time run, create needed folders.

```sh
mkdir -p ./deluge/conf
mkdir -p ./deluge/watch
mkdir -p ./deluge/dl
mkdir -p ./deluge/completed
mkdir -p ./deluge/tmp
```
Then run the container :

```sh
docker run -d --restart=always -p 8112:8112 -p 51413:51413 \
    -v ./deluge/conf:/data/conf -v ./deluge/watch:/data/watch -v ./deluge/dl:/data/dl \
    -v ./deluge/completed:/data/completed -v ./deluge/tmp:/data/tmp tchabaud/docker-deluge
``` 
