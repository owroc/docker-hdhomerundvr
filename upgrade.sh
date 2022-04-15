#!/bin/sh

now=$(date +"%m-%d-%Y-%H%M%S")

#check if there is an old version of the hdhomerun application, if so archive it
FILE=/home/owroc/docker/docker-hdhomerundvr/hdhomerun_record
if test -f "$FILE"
then
	echo "Archiving old hdhomrun file"
	mv hdhomerun_record /home/owroc/docker/docker-hdhomerundvr/archive/hdhomerun_record-$now
else
	echo"$FILE does not exist."
fi

#download the latest version of hdhomerun
wget -O hdhomerun_record https://download.silicondust.com/hdhomerun/hdhomerun_record_linux


