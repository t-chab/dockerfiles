FROM alpine:3.11

RUN apk --update add squid \
    && mkdir -p /var/log/squid

ADD squid.conf /etc/squid/squid.conf

CMD [ "/usr/sbin/squid", "-NYCd", "1"]
