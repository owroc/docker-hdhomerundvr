#!/bin/sh

now=$(date +"%m-%d-%Y-%H%M%S")

cd /home/owroc/docker/docker-hdhomerundvr

#check if there is an old version of the hdhomerun application, if so archive it
FILE=/home/owroc/docker/docker-hdhomerundvr/hdhomerun_record
if test -f "$FILE"
then
	echo "Archiving old hdhomerun file"
	mv hdhomerun_record /home/owroc/docker/docker-hdhomerundvr/archive/hdhomerun_record-$now
else
	echo"$FILE does not exist."
fi

#download the latest version of hdhomerun
wget -O hdhomerun_record https://download.silicondust.com/hdhomerun/hdhomerun_record_linux

echo "Stopping hdhomerun container"
docker stop hdhomerun
echo "Deleting existing hdhomerun container"
docker rm hdhomerun
echo "Deleting existing hdhomerun image"
docker rmi owroc/hdhomerun
echo "Building new hdhomerun image"
docker build -t owroc/hdhomerun .
echo "Starting hdhomerun container"
docker run -d --restart always --name hdhomerun --net=app_net --ip=192.168.1.204 -v /dvr:/hdhomerun owroc/hdhomerun

