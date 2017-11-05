FROM alpine:latest

ENV SAB_VERSION=2.3.1

COPY service /etc/service/
COPY freshclam.conf /etc/clamav/freshclam.conf

RUN apk --update add autoconf automake build-base git py2-pip python-dev libffi-dev libressl-dev && \
    apk --update add runit python unrar unzip p7zip freshclam clamav-libunrar clamav-scanner curl && \
    git clone https://github.com/Parchive/par2cmdline /opt/par2cmdline && \
    cd /opt/par2cmdline && aclocal && automake --add-missing && autoconf && \
    ./configure --prefix=/usr && make && make install && \
    pip install --upgrade pip && \
    pip install --upgrade cheetah feedparser pyopenssl sabyenc && \
    cd /opt && curl -O https://bitbucket.org/dual75/yenc/get/0.4.0.tar.bz2 && \
    tar xvfj *.tar.bz2 && cd *yenc* && python setup.py install --optimize=1 && \
    cd /opt && git clone https://github.com/sabnzbd/sabnzbd.git && \
    cd /opt/sabnzbd && git checkout tags/$SAB_VERSION && \
    addgroup -g 5000 sabnzbd && \
    adduser -S -s /sbin/nologin -u 5000 -h "/opt/sabnzbd" -G sabnzbd sabnzbd && \
    chown -R 5000:5000 /opt/sab* && \
    adduser -S -s /sbin/nologin log && \
    rm -rf /var/cache/apk/* && \
    chmod -R a+x /etc/service && chown -R log /etc/service/freshclam/log/main

CMD ["runsvdir", "/etc/service"]
