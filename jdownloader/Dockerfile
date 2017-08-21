FROM alpine:latest
MAINTAINER docker@chabs.name

ADD jdl.sh /usr/local/bin

RUN apk --update add bash busybox-suid desktop-file-utils fontconfig hicolor-icon-theme shared-mime-info \
    ttf-dejavu openjdk8-jre runit unzip unrar wget && \
    mkdir -p /opt/JDownloader && \
    addgroup -g 5000 jdownloader && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/JDownloader" -G jdownloader jdownloader && \
    chown -R 5000:5000 /opt && \
    chmod 755 /usr/local/bin/jdl.sh && \
    chown jdownloader.jdownloader /usr/local/bin/jdl.sh && \
    wget -O /opt/JDownloader/JDownloader.jar --progress=bar:force http://installer.jdownloader.org/JDownloader.jar && \
    chown -Rv jdownloader.jdownloader /opt/JDownloader && \
    rm -rf /var/cache/apk/*

WORKDIR /opt/JDownloader

CMD ["chpst", "-v" ,"-u", "jdownloader", "-U", "jdownloader", "/usr/local/bin/jdl.sh"]
