FROM alpine:3.12

ENV GRAV_VERSION="1.7.15"
ENV GRAV_HOME="/var/www/grav-admin"

RUN apk --no-cache --update add nginx git wget shadow ca-certificates php7 \
        php7-session php7-dom php7-fpm php7-ctype php7-json php7-gd php7-curl \
        php7-openssl php7-simplexml php7-zip php7-zlib php7-mbstring php7-xml \
        php7-exif php7-apcu php7-opcache \
    && wget "https://getgrav.org/download/core/grav-admin/${GRAV_VERSION}" -O /tmp/grav-${GRAV_VERSION}.zip \
    && unzip /tmp/grav-*.zip -d /var/www && rm -f /tmp/grav-*.zip \
    && sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php7/php.ini \
    && sed -i 's/upload_max_filesize = .*/upload_max_filesize = 15M/' /etc/php7/php.ini \
    && sed -i 's/post_max_size = .*/post_max_size = 20M/' /etc/php7/php.ini \
    && echo "catch_workers_output = yes" >> /etc/php7/php-fpm.d/www.conf \ 
    && sed -i 's/^group = nobody/group = www-data/' /etc/php7/php-fpm.d/www.conf \
    && usermod -u 5000 nginx && groupmod -g 5000 www-data \
    && chown -R nginx:www-data /var/www && chmod -R u+rwX,g+rwX,o-w /var/www \
    && mkdir -p /run/nginx \
    && rm -rf /var/cache/apk/*

COPY grav.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
