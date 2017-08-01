#!/usr/bin/env sh

# Starting deluge daemon
/usr/bin/deluged -p 58846 -c /data/conf -l /data/conf/logs/deluged.log -L warning

# Starting web-ui
PYTHON_EGG_CACHE=/home/deluge/.python-eggs /usr/bin/deluge-web -c /data/conf -l /data/conf/logs/deluge.log -L warning


