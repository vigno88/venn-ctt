# !/bin/bash 

GOOS=linux \
  GOARCH=arm \
  GOARM=7 \
  CGO_ENABLED=1 \
  CC=/home/nathan/go/src/ClearpathMotors/gcc-linaro-6.1.1-2016.08-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc \
  go build -o ./populate_metrics  -tags production  populate_metrics.go

echo "Building done"
sshpass -p pi rsync -a --info=progress2 \
  populate_metrics pi@192.168.0.119:/home/pi/scripts/.
echo "Upload Done"

