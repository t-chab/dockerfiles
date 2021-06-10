FROM alpine:3.13

RUN apk --update add squid \
    && mkdir -p /var/log/squid

ADD squid.conf /etc/squid/squid.conf
USER squid
CMD [ "/usr/sbin/squid", "-NYCd", "1"]
