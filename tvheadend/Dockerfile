ARG BIN_DEPS="ca-certificates coreutils netcat-openbsd \
    perl perl-datetime perl-json perl-lwp-protocol-https \
    pngquant tzdata xmltv "

FROM alpine:3.10 AS builder

ENV TVHEADEND_VERSION="4.2.8"
ENV DEV_TOOLS build-base bsd-compat-headers ccache cmake git mercurial

ARG BIN_DEPS
ENV BIN_DEPS=${BIN_DEPS}

ENV BUILD_DEPS xmlto linux-headers musl-dev musl-dbg \
    dbus-dev libressl-dev ffmpeg-dev faac-dev libhdhomerun-dev \
    libtheora-dev libvorbis-dev libvpx-dev libdvbcsa-dev x264-dev x265-dev opus-dev \
    avahi-dev gnu-libiconv-dev gettext-dev uriparser-dev zlib-dev

RUN apk add --no-cache --update ${BIN_DEPS} ${BUILD_DEPS} ${DEV_TOOLS} \
    && rm -rf /var/cache/apk/* \
    && update-ca-certificates \
    && mkdir -p /opt/tvh \
    && git clone "https://github.com/tvheadend/tvheadend" /opt/tvheadend \
    && cd /opt/tvheadend \
    && git checkout "tags/v${TVHEADEND_VERSION}" \
    && ./configure --prefix=/opt/tvh \
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
        --enable-avahi \
    && make \
    && make install \
    && make clean

FROM alpine:3.10

ARG BIN_DEPS
ENV BIN_DEPS=${BIN_DEPS}

ENV DEPS dbus-libs libressl ffmpeg faac libhdhomerun-libs \
    libtheora libvorbis libvpx libdvbcsa x264-libs x265-libs opus \
    avahi-libs gnu-libiconv gettext-libs liburiparser zlib

ENV TVHEADEND_UID=5000
ENV TVHEADEND_GID=5000
ENV TVHEADEND_HOME=/home/tvh

# Schedule Direct official grabber from xmltv project
ADD "https://raw.githubusercontent.com/XMLTV/xmltv/master/grab/zz_sdjson/tv_grab_zz_sdjson" /usr/bin/tv_grab_zz_sdjson

# Generic EPG grabber for IPTV providers
# Just set XMLTV_EPG_URL environment variable with EPG URL
ADD tv_grab_iptv /usr/bin/tv_grab_iptv

# Schedule direct EPG grabber wrapper for use with TVHeadend
ADD tv_grab_iptv_sd /usr/bin/tv_grab_iptv_sd

COPY --from=builder /opt/tvh/ /

RUN apk --no-cache --update add ${BIN_DEPS} ${DEPS} \
    && update-ca-certificates \
    && mkdir -p "${TVHEADEND_HOME}/.xmltv" \
    && addgroup -g ${TVHEADEND_GID} hts \
    && adduser -S -s /sbin/nologin -u ${TVHEADEND_UID} -h "${TVHEADEND_HOME}" -G hts hts \
    && chown -R ${TVHEADEND_UID}:${TVHEADEND_GID} "${TVHEADEND_HOME}" \
    && chown -R hts.hts "${TVHEADEND_HOME}" \
    && chmod 755 /usr/bin/tv_grab*

# HTSP port
EXPOSE 9982

# add custom environment file for application
VOLUME ["/data/conf", "/data/media"]

USER hts
ENTRYPOINT ["/bin/tvheadend", "-c", "/data/conf", "-p", "/run/tvheadend.pid", "-C", "-u", "hts", "-g", "hts"]

