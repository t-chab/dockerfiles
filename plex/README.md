# Description

Dockefile to build plex pass images. Just put your token in *plex.token* file, then build the image using

```
docker build -t plex --build-arg token=$(cat plex.token) .
```
