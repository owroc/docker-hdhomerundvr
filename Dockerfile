LABEL owroc <info@robcovington.com>
# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:focal-1.2.0

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
RUN mkdir /etc/service/hdhomerun
RUN mkdir /hdhomerun
COPY hdhomerun.sh /etc/service/hdhomerun/run
COPY hdhomerun.conf /hdhomerun
COPY hdhomerun_record /hdhomerun
RUN chmod +x /etc/service/hdhomerun/run
VOLUME /hdhomerun

# CLEAN UP APT WHEN DONE.
RUN APT-GET CLEAN && RM -RF /VAR/LIB/APT/LISTS/* /TMP/* /VAR/TMP/*

