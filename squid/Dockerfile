FROM alpine:3.11

RUN apk --update add squid

ADD squid.conf /etc/squid/squid.conf

CMD [ "/usr/sbin/squid", "-NYCd", "1"]
