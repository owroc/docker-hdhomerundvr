# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
# Use baseimage-docker's init system.
FROM phusion/baseimage:focal-1.2.0
LABEL owroc <info@robcovington.com>

CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN mkdir /etc/service/hdhomerun
RUN mkdir -p /opt/hdhomerun
RUN mkdir /hdhomerun
ADD hdhomerun.sh /etc/service/hdhomerun/run
RUN chmod +x /etc/service/hdhomerun/run

ADD hdhomerun.conf /opt/hdhomerun
ADD hdhomerun_record /opt/hdhomerun
RUN chmod +x /opt/hdhomerun/hdhomerun_record

VOLUME /hdhomerun
EXPOSE 65001/udp 65002

# CLEAN UP APT WHEN DONE.
# RUN APT-GET CLEAN && RM -RF /VAR/LIB/APT/LISTS/* /TMP/* /VAR/TMP/*

