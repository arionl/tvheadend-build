FROM ubuntu:14.04

VOLUME /data

RUN echo "deb http://apt.tvheadend.org/stable trusty main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.tvheadend.org/stable trusty main" >> /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y build-dep tvheadend
RUN apt-get -y install build-essential devscripts git pkg-config libssl-dev libavahi-client-dev libavcodec-dev libavfilter-dev libavformat-dev libavutil-dev libswscale-dev libavcodec-extra liburiparser-dev libiconv-hook-dev
CMD \
 cd /opt; \
 GIT_SSL_NO_VERIFY=true git clone https://github.com/tvheadend/tvheadend.git; \
 cd /opt/tvheadend; \
 dch --create --package tvheadend --v $(git describe | colrm 1 1) "build from git"; \
 dpkg-buildpackage -us -uc -nc; \
 cp ../*.deb /data
 
