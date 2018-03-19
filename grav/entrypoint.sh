#!/usr/bin/env sh

umask 0002

cd ${GRAV_HOME}
./bin/gpm install -y git-sync
chown -R nginx.www-data ${GRAV_HOME}
chown -R nginx.www-data /var/tmp/nginx
echo "File hierarchy ownership updated."
chmod -R u+rwX,g+rwX,o-w ${GRAV_HOME}
chmod -R u+rwX,g+rwX,o-w /var/tmp/nginx
echo "Permissions updated."
/usr/sbin/php-fpm7 --fpm-config /etc/php7/php-fpm.d/www.conf
/usr/sbin/nginx -g "daemon off;"
