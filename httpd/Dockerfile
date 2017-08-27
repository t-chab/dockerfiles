FROM alpine:latest
MAINTAINER docker@chabs.name

ADD httpd.sh /usr/local/bin

RUN apk -U --no-cache add apache2 apache2-ssl apache2-proxy apache2-utils perl shadow runit wget && \
    wget -O /usr/sbin/split-logfile "https://svn.apache.org/viewvc/httpd/httpd/branches/2.4.x/support/split-logfile.in?revision=1651095&view=co" && \
    sed -i -e 's/@perlbin@/\/usr\/bin\/env perl/g' /usr/sbin/split-logfile && \
    chmod +x /usr/sbin/split-logfile && \
    usermod -u 5000 apache && groupmod -g 5000 apache && \
    rm -rf /var/cache/apk/* && \
    chown apache /usr/local/bin/httpd.sh && \
    chmod a+x /usr/local/bin/httpd.sh

VOLUME ["/etc/httpd"]

EXPOSE 443 8080

CMD ["chpst", "-v" ,"-u", "apache", "-U", "apache", "/usr/local/bin/httpd.sh"]
