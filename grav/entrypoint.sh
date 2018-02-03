#!/usr/bin/env sh

umask 0002
/usr/sbin/php-fpm7 --fpm-config /etc/php7/php-fpm.d/www.conf
/usr/sbin/nginx -g "daemon off;"
