FROM ubuntu:latest

MAINTAINER docker@chabs.name

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get -q update && \
    apt-get -q -y dist-upgrade && \
    apt-get install --no-install-recommends -qy wget gnupg apt-transport-https software-properties-common && \
    add-apt-repository -y "ppa:webupd8team/java" && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get -q update && \
    apt-get install --no-install-recommends -qy google-chrome-stable oracle-java8-installer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
