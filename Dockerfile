# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM lsiobase/alpine:3.7

LABEL description="Unified Remote Server"
	
RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	bluez-libs \
	&& \
 echo "**** create remotes mountpoint ****" && \
 mkdir -p \
	/config \
	&& \
 echo "**** install urserver ****" && \
 mkdir -p \
	/app/urserver && \
 curl -o \
	/tmp/urserver.tar.gz -L \
	http://www.unifiedremote.com/d/linux-x64-portable && \
 tar -zxvf /tmp/urserver.tar.gz -C /tmp && \
 cp -r /tmp/urserver*/ /app/urserver && \
 echo "**** configure urserver ****" && \
# cp /app/nzbget/nzbget.conf /defaults/nzbget.conf && \
# sed -i \
#	-e "s#\(MainDir=\).*#\1/downloads#g" \
#	-e "s#\(ScriptDir=\).*#\1$\{MainDir\}/scripts#g" \
#	-e "s#\(WebDir=\).*#\1$\{AppDir\}/webui#g" \
#	-e "s#\(ConfigTemplate=\).*#\1$\{AppDir\}/webui/nzbget.conf.template#g" \
# /defaults/nzbget.conf && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

#9510 is for web, 9512 for wifi connections, 9511 automatic server discovery
EXPOSE 9510/tcp 9512/tcp 9512/udp 9511/udp

#Mount config volume
VOLUME /config /remotes
