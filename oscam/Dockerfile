FROM alpine:latest

MAINTAINER docker@chabs.name

#ENV OSCAM_SVN http://streamboard.tv/svn/oscam/trunk
ENV OSCAM_SVN http://oscam.cc/svn/oscam-mirror/trunk

RUN apk add --no-cache --update --virtual build_deps build-base subversion cmake paxmark linux-headers bsd-compat-headers && \
    apk add --no-cache --update coreutils runit ca-certificates wget libressl-dev pcsc-lite-dev libusb-dev && \
    update-ca-certificates && \
    mkdir /opt && \
    cd /opt && \
    svn co ${OSCAM_SVN} oscam && \
    cd oscam && \
    make allyesconfig && \
    make OSCAM_BIN=oscam LIST_SMARGO_BIN=list_smargo CONF_DIR=/etc/oscam USE_LIBUSB=1 USE_PCSC=1 DEFAULT_PCSC_FLAGS="-I/usr/include/PCSC" && \
    addgroup -g 5000 oscam && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/oscam*" -G oscam oscam && \
    mkdir /etc/oscam && \
    chown -R 5000:5000 /opt/oscam && \
    chown -R 5000:5000 /etc/oscam && \
    rm -rf /var/cache/apk/* && apk del --purge build_deps

CMD ["/sbin/chpst", "-v" ,"-u", "oscam", "-U", "oscam", "/opt/oscam/oscam", "-u"]

