#!/bin/sh

# this path allows the import of the .so library modules located in the /opt/plexmediaserver folder
export LD_LIBRARY_PATH=/usr/lib/plexmediaserver

# set env variables for plex
export PLEX_USER=plex
export PLEX_MEDIA_SERVER_USER=plex
export PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver
export PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR=/data/conf
export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6
export PLEX_MEDIA_SERVER_TMPDIR=/data/conf/tmp
export TMPDIR="${PLEX_MEDIA_SERVER_TMPDIR}"

# this specifies the folder to store temporary transcodes
export TMPDIR='/data/conf/tmp'

#export LC_ALL="en_US.UTF-8"
#export LANG="en_US.UTF-8"

export LC_ALL="C"

# kick off main process
rm -rf /data/conf/Plex\ Media\ Server/plexmediaserver.pid
exec "/usr/lib/plexmediaserver/Plex Media Server"
