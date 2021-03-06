# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.22

LABEL description="Unified Remote Server"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Update Ubuntu, and install libbluetooth3 (dependency)
RUN apt-get update && \
	apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
	apt-get install -y libbluetooth3 \
	&& \
	#Create mount points for configuration, remote data
	mkdir /config && \
	mkdir /remotes && \
	#Create directory for temporary installation files
	mkdir /ur && \
	# Add user
    useradd -U -d /config -s /bin/false ur && \
    usermod -G users ur

#Copy scripts and env vars into container
COPY etc/ /etc

#Copy the starting config file into the container temp install dir
COPY urserver.config /ur

#Make startup scripts executable
RUN chmod +x /etc/my_init.d/*.sh
		
#9510 is for web, 9512 for wifi connections, 9511 automatic server discovery
EXPOSE 9510/tcp 9512/tcp 9512/udp 9511/udp

#Mount config volume
VOLUME /config /remotes

ENV HOME=/config \
	CHANGE_CONFIG_DIR_OWNERSHIP="true" 

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


