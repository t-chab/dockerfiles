FROM alpine:3.8

LABEL MAINTAINER=docker@chabs.name

ENV TVHEADEND_VERSION="4.2.7"
ENV TVHEADEND_UID=5000
ENV TVHEADEND_GID=5000

ENV DEV_TOOLS build-base bsd-compat-headers ccache cmake git mercurial
ENV DEPS dbus-dev faac-dev libhdhomerun-dev libressl-dev libtheora-dev \
    libvorbis-dev libvpx-dev musl-dev perl ffmpeg ffmpeg-dev libdvbcsa-dev uriparser-dev \
    x264-dev x265-dev zlib-dev linux-headers xmlto gettext-dev opus-dev \
    xmltv perl-json perl-datetime perl-lwp-protocol-https tzdata

# Generic EPG grabber for IPTV providers
# Just set XMLTV_EPG_URL environment variable with EPG URL
ADD tv_grab_iptv /usr/bin/tv_grab_iptv

# Schedule Direct official grabber from xmltv project
ADD --chmod=755 "https://raw.githubusercontent.com/XMLTV/xmltv/master/grab/zz_sdjson/tv_grab_zz_sdjson" /usr/bin/tv_grab_zz_sdjson
ADD sd_grab.conf /data/conf/sd_grab.conf

RUN apk --no-cache --update add coreutils python3 libhdhomerun-libs ca-certificates \
    && apk add --no-cache --virtual build_deps ${DEV_TOOLS} \
    && apk add --no-cache ${DEPS} \
    && update-ca-certificates \
    && pip3 install gzip-reader \
    && mkdir /opt \
    && cd /opt && hg clone "http://linuxtv.org/hg/dvb-apps" \
    && cd dvb-apps && export PERL_USE_UNSAFE_INC=1 && make && make install \
    && cd /opt && git clone "https://github.com/tvheadend/tvheadend" \
    && cd tvheadend && git checkout "tags/v${TVHEADEND_VERSION}" \
    && addgroup -g ${TVHEADEND_GID} hts \
    && adduser -S -s /sbin/nologin -u ${TVHEADEND_UID} -h "/opt/tvheadend" -G hts hts \
    && chown -R ${TVHEADEND_UID}:${TVHEADEND_GID} /opt/tvheadend \
    && cd /opt/tvheadend \
    && ./configure --prefix=/usr \
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
        --disable-avahi \
    && make && make install && make clean \
    && rm -rf /var/cache/apk/* \
    && rm -rf /opt \
    && apk del --purge build_deps

# HTSP port
EXPOSE 9982

# add custom environment file for application
VOLUME ["/data/conf", "/data/media"]

USER hts
ENTRYPOINT ["/usr/bin/tvheadend", "-c", "/data/conf", "-p", "/run/tvheadend.pid", "-C", "-u", "hts", "-g", "hts"]
