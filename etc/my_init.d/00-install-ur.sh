#!/bin/sh

mkdir /ur
mkdir /urserver
curl -J -L -o /ur/urserver.tar.gz http://www.unifiedremote.com/d/linux-x64-portable
cd /ur
tar -zxvf urserver.tar.gz
cd urserver*/
cp -r . /urserver
rm -rf /ur