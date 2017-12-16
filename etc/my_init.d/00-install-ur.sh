#!/bin/sh

mkdir /ur
curl -J -L -o /ur/urserver.tar.gz http://www.unifiedremote.com/d/linux-x64-portable
tar -zxvf /ur/urserver.tar.gz
rm /ur/urserver.tar.gz
