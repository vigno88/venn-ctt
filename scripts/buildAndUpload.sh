#!/bin/bash

USER=pi
PASSWORD=pi
IP=192.168.0.118

# Build proto files
./compileProto.sh

cd ../VennServer/scripts
./build.sh production
echo 'Built golang project'
./upload.sh $IP 
echo 'Uploaded golang project'
cd ../../scripts/

cd ../VennUI/
./build.sh
echo 'Built flutter project'
./upload.sh $IP
echo 'Uploaded flutter project'

# Upload config file
cd ..
sshpass -p $PASSWORD \
  rsync -a --info=progress2 \
  ./VennServer/configs/config.yaml \
  $USER@$IP:/home/pi/config/config.yaml
# sshpass -p $PASSWORD \
#   rsync -a --info=progress2 \
#   ./VennServer/configs/key \
#   $USER@$IP:/home/pi/config/key
echo 'Uploaded config file'

