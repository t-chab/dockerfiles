FROM alpine:latest

MAINTAINER docker@chabs.name

ENV DEV_TOOLS build-base bsd-compat-headers ccache cmake git mercurial
ENV DEPS dbus-dev faac-dev libhdhomerun-dev libressl-dev libtheora-dev libvorbis-dev libvpx-dev musl-dev perl ffmpeg-dev libdvbcsa-dev uriparser-dev x264-dev x265-dev zlib-dev linux-headers xmlto gettext-dev opus-dev

# TV Grabber Kazer for french TV programs
ADD tv_grab_kazer /usr/bin/tv_grab_kazer

RUN apk --no-cache --update add coreutils runit python3 libhdhomerun-libs ca-certificates wget && \
    apk add --no-cache --virtual build_deps ${DEV_TOOLS} && \
    apk add --no-cache ${DEPS} && \
    update-ca-certificates && \
    pip3 install gzip-reader && \
    mkdir /opt && \
    cd /opt && hg clone "http://linuxtv.org/hg/dvb-apps" && cd dvb-apps && export PERL_USE_UNSAFE_INC=1 && make && make install && \
    cd /opt && git clone "https://github.com/tvheadend/tvheadend" && cd tvheadend && git checkout "tags/v4.2.4" && \
    addgroup -g 5000 hts && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/tvheadend" -G hts hts && \
    chown -R 5000:5000 /opt/tvheadend && \
    cd /opt/tvheadend && \
    ./configure --prefix=/usr \
        --enable-libav \
        --disable-libav_static \
        --enable-dvbcsa \
        --enable-hdhomerun_client \
        --disable-hdhomerun_static \
        --disable-ffmpeg_static \
        --disable-libx264_static \
        --disable-libx265_static \
        --disable-libvpx_static \
        --disable-libtheora_static \
        --disable-libvorbis_static \
        --disable-libfdkaac_static \
        --disable-avahi && \
    make && make install && \
    rm -rf /var/cache/apk/* && apk del --purge build_deps

# HTSP port
EXPOSE 9982

# add custom environment file for application
VOLUME ["/data/conf", "/data/media"]

# run supervisor
CMD ["/sbin/chpst", "-v" ,"-u", "hts", "-U", "hts", "/usr/bin/tvheadend", "-c", "/data/conf", "-d", "-p", "/run/tvheadend.pid", "-C", "-u", "hts", "-g", "hts"]

