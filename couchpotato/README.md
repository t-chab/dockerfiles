# docker-couchpotato

Simple Dockerfile to build couchpotato containers

# Usage

For first time launch, you need to create configuration and download folders :

```sh
mkdir -p ./couchp/conf
mkdir -p ./couchp/media
mkdir -p ./couchp/dl
```

Then run the container using following command :

```sh
docker run -d --restart=always -v ./couchp/dl:/data/dl -v ./couchp/media:/data/media -v ./couchp/conf:/data/conf tchabaud/docker-couchpotato
```

