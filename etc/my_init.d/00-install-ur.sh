#!/bin/sh

mkdir /urserver
echo Downloading Unified Remote Server from http://www.unifiedremote.com/d/linux-x64-portable
curl -J -L -o /ur/urserver.tar.gz http://www.unifiedremote.com/d/linux-x64-portable
cd /ur
echo Untarring server files
tar -zxvf urserver.tar.gz
cd urserver*/
echo Copying server files
cp -r . /urserver

if [ -e /config/urserver.config ]
then
	echo urserver.config already in /config, skipping copy.
else
	echo urserver.config not found in /config, copying default.
	cp urserver.config /config
fi

#echo Cleaning up temporary installation files
#rm -rf /ur