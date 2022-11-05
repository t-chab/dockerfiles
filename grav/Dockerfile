FROM alpine:3.16

ENV GRAV_VERSION="1.7.37.1"
ENV GRAV_HOME="/var/www/grav-admin"

RUN apk --no-cache --update add nginx git wget shadow ca-certificates php81 \
        php81-session php81-dom php81-fpm php81-ctype php81-json php81-gd php81-curl \
        php81-openssl php81-simplexml php81-zip php81-zlib php81-mbstring php81-xml \
        php81-exif php81-apcu php81-opcache \
    && wget -4 "https://getgrav.org/download/core/grav-admin/${GRAV_VERSION}" -O /tmp/grav-${GRAV_VERSION}.zip \
    && unzip /tmp/grav-*.zip -d /var/www && rm -f /tmp/grav-*.zip \
    && sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php81/php.ini \
    && sed -i 's/upload_max_filesize = .*/upload_max_filesize = 15M/' /etc/php81/php.ini \
    && sed -i 's/post_max_size = .*/post_max_size = 20M/' /etc/php81/php.ini \
    && echo "catch_workers_output = yes" >> /etc/php81/php-fpm.d/www.conf \
    && sed -i 's/^group = nobody/group = www-data/' /etc/php81/php-fpm.d/www.conf \
    && usermod -u 5000 nginx && groupmod -g 5000 www-data \
    && chown -R nginx:www-data /var/www && chmod -R u+rwX,g+rwX,o-w /var/www \
    && mkdir -p /run/nginx \
    && rm -rf /var/cache/apk/*

COPY grav.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
