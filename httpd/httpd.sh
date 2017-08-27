#!/usr/bin/env sh

# Cleanup previous PID file, just in case last instance failed
rm -rf /etc/httpd/logs/httpd.pid

# Launch Apache httpd daemon
/usr/sbin/httpd -DFOREGROUND -f /etc/httpd/conf/httpd.conf -E /etc/httpd/logs/startup_errors.log
