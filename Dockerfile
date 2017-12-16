# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.22

LABEL description="Unified Remote Server"



#Update Ubuntu, and install curl
RUN apt-get update && \
	apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
	apt-get install -y curl

#Copy scripts and env vars into container
COPY etc/ /etc

#Make startup scripts executable
RUN chmod +x /etc/my_init.d/*.sh
		
EXPOSE 9510/tcp
	#

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]