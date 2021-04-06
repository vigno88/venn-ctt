#!/bin/bash

PASSWORD=pi
IP=$1
USER=pi

# Upload assets to pi
sshpass -p $PASSWORD \
  rsync -a --info=progress2 \
  ./build/flutter_assets/ \
  $USER@$IP:/home/pi/flutter_assets

