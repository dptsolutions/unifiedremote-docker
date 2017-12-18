#!/bin/bash

mkdir /urserver

if [ -e /config/urserver.config ]
then
	echo urserver.config already in /config, skipping copy.
else
	echo urserver.config not found in /config, copying default.
	cp /ur/urserver.config /config
fi

echo Downloading Unified Remote Server from http://www.unifiedremote.com/d/linux-x64-portable
curl -J -L -o /ur/urserver.tar.gz http://www.unifiedremote.com/d/linux-x64-portable

echo Untarring server files
cd /ur
tar -zxvf urserver.tar.gz

echo Copying server files
cd urserver*/
cp -r . /urserver

echo Cleaning up temporary installation files
rm -rf /ur