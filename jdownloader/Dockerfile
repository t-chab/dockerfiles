FROM alpine:latest
MAINTAINER docker@chabs.name

RUN apk --update add bash busybox-suid desktop-file-utils fontconfig hicolor-icon-theme shared-mime-info ttf-dejavu openjdk8-jre runit unzip unrar wget

RUN mkdir -p /opt/JDownloader

# Add user
RUN addgroup -g 5000 jdownloader && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/JDownloader" -G jdownloader jdownloader && \
    chown -R 5000:5000 /opt/# Install package
ADD jdl.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/jdl.sh && \
    chown jdownloader.jdownloader /usr/local/bin/jdl.sh

# Download JDownloader jar
RUN wget -O /opt/JDownloader/JDownloader.jar --progress=bar:force http://installer.jdownloader.org/JDownloader.jar && \
    chown -Rv jdownloader.jdownloader /opt/JDownloader

RUN rm -rf /var/cache/apk/*

WORKDIR /opt/JDownloader

CMD ["chpst", "-v" ,"-u", "jdownloader", "-U", "jdownloader", "/usr/local/bin/jdl.sh"]
