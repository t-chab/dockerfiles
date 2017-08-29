FROM alpine:latest

RUN apk --update add python git runit && \
    mkdir /opt && cd /opt && git clone https://github.com/rembo10/headphones && \
    addgroup -g 5000 headphones && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/headphones" -G headphones headphones && \
    chown -R 5000:5000 /opt/headphones && \
    rm -rf /var/cache/apk/*

CMD ["/sbin/chpst", "-v" ,"-u", "headphones", "-U", "headphones", "/usr/bin/env", "python2", "/opt/headphones/Headphones.py", "--datadir", "/data/conf", "--config", "/data/conf/config.ini", "--nolaunch"]
