FROM alpine:latest

RUN apk --update add python git py-lxml py-cffi py-six py-openssl py-cryptography py-enum34 runit && \
    mkdir /opt && cd /opt && git clone https://github.com/CouchPotato/CouchPotatoServer.git && \
    addgroup -g 5000 couchpotato && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/CouchPotatoServer" -G couchpotato couchpotato && \
    chown -R 5000:5000 /opt/CouchPotatoServer && \
    rm -rf /var/cache/apk/*

CMD ["/sbin/chpst", "-v" ,"-u", "couchpotato", "-U", "couchpotato", "/usr/bin/env","python2", "/opt/CouchPotatoServer/CouchPotato.py", "--config_file",  "/data/conf/config.ini", "--data_dir", "/data/conf"]
