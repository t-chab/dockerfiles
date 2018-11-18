# tvheadend Dockerfile

Dockerfile to build latest stable tvheadend version from git.
Just clone this repo, then :

```sh
cd tvheadend
docker build -t tvheadend .
```

Then you could run the container with this command :

```sh
docker run -d --restart=always -p 9981:9981 -p 9982:9982 --name tv \
    && --device=/dev/dvb/adapter0:/dev/dvb/adapter0 \
    && -e XMLTV_EPG_URL='your_iptv_provider_epg_xmltv_url' \
    && -v /data/tvheadend/conf:/data/conf \
    && -v /data/tvheadend/dvr:/data/media tvheadend
```
