FROM alpine:latest

# Python minimal stuff
RUN apk --update add python git unrar nodejs-current && \
    git clone https://github.com/SickChill/SickChill.git /opt/sickchill && \
    addgroup -g 5000 sickchill && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/sickchill" -G sickchill sickchill && \
    chown -R 5000:5000 /opt/sickchill && \
    rm -rf /var/cache/apk/*

USER sickchill
ENTRYPOINT ["python2", "/opt/sickchill/SickBeard.py", "-q", "--config", "/data/conf/config.ini", "--datadir", "/data/conf"]

