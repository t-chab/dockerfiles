FROM alpine:latest

RUN apk --update add python2 git py2-lxml runit && \
    git clone https://github.com/theotherp/nzbhydra /opt/nzbhydra && \
    addgroup -g 5000 nzbhydra && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/nzbhydra" -G nzbhydra nzbhydra && \
    chown -R 5000:5000 /opt/nzbhydra && \
    rm -rf /var/cache/apk/*

CMD ["chpst", "-v" ,"-u", "nzbhydra", "-U", "nzbhydra", "/usr/bin/env", "python2", "/opt/nzbhydra/nzbhydra.py", "--nobrowser", "--pidfile", "/opt/nzbhydra/nzbhydra.pid", "--config", "/data/conf/settings.cfg", "--database", "/data/conf/nzbhydra.db", "--logfile", "/data/conf/nzbhydra.log"]
