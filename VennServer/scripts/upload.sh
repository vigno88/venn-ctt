#!/bin/bash
USER=pi
PASSWORD=pi
IP=$1
# IP=192.168.0.125

sshpass -p $PASSWORD rsync -a --info=progress2 \
  ../main $USER@$IP:/home/pi/server/VennServer
