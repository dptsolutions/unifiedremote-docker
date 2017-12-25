# Using LinuxServer.io's Xenial base, even though they say not to.
# I'll fix it later I guess
FROM lsiobase/xenial:83

LABEL description="Unified Remote Server"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config" \
	
RUN \
 echo "**** install packages ****" && \ #libbluetooth3
  apt-get update && \
  apt-get install -y \
	libbluetooth3 && \
 echo "**** create remotes mountpoint ****" && \
 mkdir -p \
	/remotes && \
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
  apt-get clean && \
  rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

#9510 is for web, 9512 for wifi connections, 9511 automatic server discovery
EXPOSE 9510/tcp 9512/tcp 9512/udp 9511/udp

#Mount config volume
VOLUME /config /remotes
