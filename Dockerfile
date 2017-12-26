# Using LinuxServer.io's Xenial base, even though they say not to.
# I'll fix it later I guess
FROM lsiobase/xenial:83

LABEL description="Unified Remote Server"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"
	
RUN \
 echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
	libbluetooth3 && \
 echo "**** install urserver ****" && \
 mkdir -p \
	/app/urserver && \
 curl -o \
	/tmp/urserver.tar.gz -L \
	http://www.unifiedremote.com/d/linux-x64-portable && \
 tar -zxvf /tmp/urserver.tar.gz -C /tmp && \
 cd 
 cp -r /tmp/urserver*/* /app/urserver && \
 echo "**** configure urserver ****" && \
 echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*
	
# add local files
COPY root/ /

#9510 is for web, 9512 for wifi connections, 9511 automatic server discovery
EXPOSE 9510/tcp 9512/tcp 9512/udp 9511/udp

#Mount config volume
VOLUME /config /remotes
