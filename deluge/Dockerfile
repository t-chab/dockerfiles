FROM alpine:latest

LABEL maintainer="docker@chabs.name"

ADD deluge.sh /home/deluge/deluge.sh

RUN apk --update add --virtual build-dependencies git python-dev wget && \
    apk --update add boost-python boost-system geoip libressl libtorrent && \
    p7zip py2-pip runit unrar && \
    mkdir -p /opt && cd /opt && git clone http://git.deluge-torrent.org/deluge && \
    cd /opt/deluge && git checkout tags/deluge-1.3.15 && \
    pip install --upgrade pip && pip install chardet cffi cryptography \
    mako pyopenssl pyxdg service_identity six slimit twisted && \
    cd /opt/deluge && python setup.py build && python setup.py install && \
    python -c "import libtorrent; print('LIBTORRENT ENABLED WITH VERSION=' + libtorrent.version)" && \
    mkdir -p /usr/share/GeoIP && \
    wget -N "http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz" -O /tmp/GeoIP.dat.gz && \
    gunzip /tmp/GeoIP.dat.gz && mv /tmp/GeoIP.dat /usr/share/GeoIP/GeoIP.dat && \
    addgroup -g 5000 deluge && \
    adduser -S -s /sbin/nologin -u 5000 -h "/home/deluge" -G deluge deluge && \
    rm -rf /var/cache/apk/* && rm -rf /opt && apk del build-dependencies && \
    chmod a+x /home/deluge/deluge.sh && chown -R 5000:5000 /home/deluge

VOLUME ["/data/conf", "/data/watch", "/data/dl", "/data/completed", "/data/tmp"]

EXPOSE 51413

CMD ["chpst", "-v" ,"-u", "deluge", "-U", "deluge", "/home/deluge/deluge.sh"]
