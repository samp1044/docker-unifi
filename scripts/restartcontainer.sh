#! /bin/bash

USERH=$1

docker stop unifi
docker rm unifi
docker run -d \
	-p 3478:3478/udp \
	-p 8080:8080 \
	-p 8443:8443 \
	-p 8843:8843 \
	-p 8880:8880 \
	-p 10001:10001/udp \
	-v $USERH/config:/var/lib/unifi -v $USERH/logs:/var/log/unifi --name=unifi --cap-add DAC_READ_SEARCH unifi ./start.sh


