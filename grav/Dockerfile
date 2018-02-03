FROM alpine:latest

ENV GRAV_VERSION="latest"

RUN apk --no-cache --update add nginx php7 php7-session php7-dom php7-fpm php7-ctype php7-json php7-gd php7-curl php7-openssl \
        php7-zip php7-zlib php7-mbstring php7-xml php7-apcu php7-opcache wget ca-certificates \
    && wget "https://getgrav.org/download/core/grav-admin/${GRAV_VERSION}" -O /tmp/grav-${GRAV_VERSION}.zip \
    && unzip /tmp/grav-*.zip -d /var/www && rm -f /tmp/grav-*.zip \
    && sed -i 's/^group = nobody/group = www-data/' /etc/php7/php-fpm.d/www.conf \
    && chown -R nginx:www-data /var/www && chmod -R u+rwX,g+rwX,o-w /var/www \
    && mkdir -p /run/nginx \
    && rm -rf /var/cache/apk/*

COPY grav.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
