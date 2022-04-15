#!/bin/sh

docker pull thousandeyes/enterprise-agent
docker stop 'cuvapps' > /dev/null
docker rm 'cuvapps' > /dev/null
docker run \
  --hostname='cuvapps' \
  --memory=2g \
  --memory-swap=2g \
  --detach=true \
  --tty=true \
  --shm-size=512M \
  -e TEAGENT_ACCOUNT_TOKEN=ishi608y2zuohgh5ql4nckjkp9qox3i2 \
  -e TEAGENT_INET=4 \
  -v '/docker/thousandeyes/cuvapps/te-agent':/var/lib/te-agent \
  -v '/docker/thousandeyes/cuvapps/te-browserbot':/var/lib/te-browserbot \
  -v '/docker/thousandeyes/cuvapps/log/':/var/log/agent \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_ADMIN \
  --name 'cuvapps' \
  --restart=unless-stopped \
  --security-opt apparmor=docker_sandbox \
  --security-opt seccomp=/var/docker/configs/te-seccomp.json \
  thousandeyes/enterprise-agent /sbin/my_init
