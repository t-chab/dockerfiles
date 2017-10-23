FROM ubuntu:latest

MAINTAINER docker@chabs.name

ARG token

ADD plex.sh /usr/local/bin

ADD getPlexUrl.py /tmp

RUN groupadd -r -g 5000 plex && \
    useradd -s /sbin/nologin -u 5000 -c "Plex user" -d "/usr/lib/plexmediaserver" -g plex plex && \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get -q update && apt-get install --no-install-recommends -qy dbus avahi-daemon runit python3 ca-certificates udev && \
    cd /tmp && python3 getPlexUrl.py ${token} && \
    dpkg -i /tmp/*plex*.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown -R plex.plex /usr/lib/plexmediaserver && \
    chown plex.plex /usr/local/bin/plex.sh && chmod a+x /usr/local/bin/plex.sh

VOLUME ["/data/conf", "/media"]

EXPOSE 32400

CMD ["chpst", "-v" ,"-u", "plex", "-U", "plex", "/usr/local/bin/plex.sh"]
