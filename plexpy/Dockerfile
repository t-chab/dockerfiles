FROM alpine:latest

RUN apk --update add python git py-cffi py-six py-openssl py-cryptography py-enum34 runit && \
    mkdir /opt && cd /opt && git clone https://github.com/drzoidberg33/plexpy.git && \
    addgroup -g 5000 plexpy && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/plexpy" -G plexpy plexpy && \
    chown -R 5000:5000 /opt/plexpy && \
    rm -rf /var/cache/apk/*

CMD ["/sbin/chpst", "-v" ,"-u", "plexpy", "-U", "plexpy", "/usr/bin/env", "python2", "/opt/plexpy/PlexPy.py", "--datadir", "/data/conf", "--config", "/data/conf/config.ini", "--nolaunch"]
