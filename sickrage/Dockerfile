FROM alpine:latest

# Python minimal stuff
RUN apk --update add python git unrar runit && \
    git clone https://github.com/SickRage/SickRage /opt/sickrage && \
    addgroup -g 5000 sickrage && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/sickrage" -G sickrage sickrage && \
    chown -R 5000:5000 /opt/sickrage && \
    rm -rf /var/cache/apk/*

CMD ["chpst", "-v" ,"-u", "sickrage", "-U", "sickrage", "/usr/bin/env", "python2", "/opt/sickrage/SickBeard.py", "-q", "--config", "/data/conf/config.ini", "--datadir", "/data/conf"]
