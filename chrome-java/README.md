# Description

Dockerfile to create Ubuntu based container, with latest Java and Google Chrome installed.

# Quirks

Chrome must be launched with *no-sandbox* option, otherwise it will fail.

```
xhost +local:root
docker run -i -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw tchabaud/chrome-java google-chrome-stable --no-sandbox
```
