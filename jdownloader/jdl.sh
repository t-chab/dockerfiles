#!/usr/bin/env sh
set -e

# Display settings on standard out.
USER="jdownloader"
JDL_HOME=/opt/JDownloader

# Set directory permissions.
echo "Setting permissions... "
chown -R ${USER}: ${JDL_HOME}

#
# Finally, start JDownloader.
#
echo "Starting JDownloader..."
/usr/bin/env java -Djava.awt.headless=true -jar ${JDL_HOME}/JDownloader.jar -norestart -console

