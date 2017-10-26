# Description

Simple Ubuntu based Skype Dockerfile

# Usage

## Quick start

- Run container

```
mkdir skype-conf
docker run -d --restart=always -p 127.0.0.1:2223:22 --name skype \
    --device=/dev/video0:/dev/video0 -v /dev/snd:/dev/snd \
    -v ./skype-conf:/home/skype/.Skype tchabaud/skype
```

- Launch containerized Skype through *ssh*

```
ssh -p 2223 -R 64713:localhost:4713 -X skype@127.0.0.1 /usr/local/bin/skype-pulseaudio
```

## Full build

- Fetch the Dockerfile 

```
git clone https://github.com/tchabaud/dockerfiles
cd dockerfiles
```

- Build the image

```
cd skype
docker build -t skype .
```

- Run container

```
mkdir skype-conf
docker run -d --restart=always -p 127.0.0.1:2223:22 --name skype \
    --device=/dev/video0:/dev/video0 -v /dev/snd:/dev/snd \
    -v ./skype-conf:/home/skype/.Skype skype
```


- Launch containerized Skype through *ssh*

```
ssh -p 2223 -R 64713:localhost:4713 -X skype@127.0.0.1 /usr/local/bin/skype-pulseaudio
```
