FROM alpine:latest

# Python minimal stuff
RUN apk --update add python git unrar nodejs-current && \
    git clone https://github.com/SickRage/SickRage /opt/sickrage && \
    addgroup -g 5000 sickrage && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/sickrage" -G sickrage sickrage && \
    chown -R 5000:5000 /opt/sickrage && \
    rm -rf /var/cache/apk/*

USER sickrage
ENTRYPOINT ["python2", "/opt/sickrage/SickBeard.py", "-q", "--config", "/data/conf/config.ini", "--datadir", "/data/conf"]

