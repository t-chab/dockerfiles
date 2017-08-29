#!/usr/bin/env python3

import sys
import urllib.request
import xml.etree.ElementTree

PLEX_URL_ROOT="https://plex.tv/downloads/details/1?build=linux-ubuntu-x86_64&channel=8&distro=ubuntu&X-Plex-Token="
plexXml = urllib.request.urlopen(PLEX_URL_ROOT + sys.argv[1]).read()
e = xml.etree.ElementTree.fromstring(plexXml)
for release in e.findall('Release'):
    for package in release.findall('Package'):
        plexUrl = package.get('url')

urllib.request.urlretrieve (plexUrl, 'plex.deb')
