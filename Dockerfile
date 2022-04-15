FROM phusion/baseimage:focal-1.2.0
MAINTAINER owroc <info@robcovington.com>
#Based on the work of gfjardim <gfjardim@gmail.com>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]


#########################################
##         RUN INSTALL SCRIPT          ##
#########################################

RUN mkdir -p /opt/hdhomerun
ADD hdhomerun.conf /etc/
ADD install.sh /
ADD hdhomerun_record_x64 /opt/hdhomerun/
RUN bash /install.sh
ADD supervisord.conf supervisord.conf

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

VOLUME /dvr
EXPOSE 65001/udp 65002

CMD ["-n", "-c", "/supervisord.conf"]
ENTRYPOINT ["/usr/bin/supervisord"]
