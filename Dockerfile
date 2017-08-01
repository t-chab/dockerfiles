FROM alpine:latest
MAINTAINER docker@chabs.name

ENV AMULE_VERSION 2.3.2
ENV UPNP_VERSION 1.6.22
ENV CRYPTOPP_VERSION CRYPTOPP_5_6_5

RUN apk --update add gd geoip libpng libwebp runit wxgtk2.8 zlib && \
    apk --update add --virtual build-dependencies alpine-sdk automake autoconf bison g++ gcc gd-dev geoip-dev gettext gettext-dev git libpng-dev libwebp-dev libtool libsm-dev make musl-dev wget wxgtk2.8-dev zlib-dev

# Build libupnp
RUN mkdir -p /opt && cd /opt && \
    wget "http://downloads.sourceforge.net/sourceforge/pupnp/libupnp-${UPNP_VERSION}.tar.bz2" && \
    tar xvfj libupnp*.tar.bz2 && cd libupnp* && ./configure --prefix=/usr && make && make install

# Build crypto++
RUN mkdir -p /opt && cd /opt && \
    git clone --branch ${CRYPTOPP_VERSION} --single-branch "https://github.com/weidai11/cryptopp" /opt/cryptopp && \
    cd /opt/cryptopp && \
    sed -i -e 's/^CXXFLAGS/#CXXFLAGS/' GNUmakefile && export CXXFLAGS="${CXXFLAGS} -DNDEBUG -fPIC" && \
    make -f GNUmakefile && make libcryptopp.so && install -Dm644 libcryptopp.so* /usr/lib/ && \
    mkdir -p /usr/include/cryptopp && install -m644 *.h /usr/include/cryptopp/

# Build amule from source
RUN mkdir -p /opt/amule && \
    git clone --branch ${AMULE_VERSION} --single-branch "https://github.com/amule-project/amule" /opt/amule && \
    cd /opt/amule && ./autogen.sh && ./configure \
        --disable-gui \
        --disable-amule-gui \
        --disable-wxcas \
        --disable-alc \
        --disable-plasmamule \
        --disable-kde-in-home \
	--prefix=/usr \
        --mandir=/usr/share/man \
        --enable-unicode \
        --without-subdirs \
        --without-expat \
        --enable-amule-daemon \
	--enable-amulecmd \
	--enable-webserver \
        --enable-cas \
	--enable-alcc \
	--enable-fileview \
	--enable-geoip \
        --enable-mmap \
        --enable-optimize \
	--enable-upnp \
	--disable-debug && \
    make && \
    make install

# Add startup script
ADD amule.sh /home/amule/amule.sh

# Add user and home
RUN addgroup -g 5000 amule && \
    adduser -S -s /sbin/nologin -u 5000 -h "/home/amule" -G amule amule && \
    chown -R 5000:5000 /home/amule && \
    chown amule.amule /home/amule/amule.sh && \
    chmod a+x /home/amule/amule.sh

RUN rm -rf /var/cache/apk/* && rm -rf /opt && apk del build-dependencies

EXPOSE 4711/tcp 4712/tcp 4672/udp 4665/udp 4662/tcp 4661/tcp

CMD ["chpst", "-v" ,"-u", "amule", "-U", "amule", "/home/amule/amule.sh"]

