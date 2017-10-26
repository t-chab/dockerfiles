FROM ubuntu:latest

MAINTAINER docker@chabs.name

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

ENV URL_SKYPE="https://repo.skype.com/latest/skypeforlinux-64.deb"

RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y --no-install-recommends apt-utils locales libpulse0 \
    pulseaudio gconf-service libatk1.0-0 libcairo2 \
    libcups2 libfontconfig1 libfreetype6 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
    libgnome-keyring0 libgtk2.0-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 \
    libxcomposite1 libxcursor1 libxdamage1 libxfixes3 libxi6 libxss1 gnome-keyring \
    openssh-server wget ca-certificates apt-transport-https && \
    wget "$URL_SKYPE" -O /usr/src/skype.deb && \
    dpkg -i /usr/src/skype.deb || true && \
    apt-get install -fy --no-install-recommends && \
    useradd -m -d /home/docker docker && echo "docker:docker" | chpasswd && \
    mkdir -p /var/run/sshd && echo X11Forwarding yes >> /etc/ssh/ssh_config && \
    mkdir /home/docker/.ssh && chown -R docker:docker /home/docker && chown -R docker:docker /home/docker/.ssh && \
    localedef -c -i "fr_FR" -f "UTF-8" "fr_FR.UTF-8" || true && \
    echo "Europe/Paris" > /etc/timezone && \
    echo 'export PULSE_SERVER="tcp:localhost:64713"' >> /usr/local/bin/skype-pulseaudio && \
    echo 'PULSE_LATENCY_MSEC=60 skype' >> /usr/local/bin/skype-pulseaudio && \
    chmod 755 /usr/local/bin/skype-pulseaudio

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]

