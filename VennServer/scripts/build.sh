#!/bin/bash

# Build go project
env GOOS=linux GOARCH=arm GOARM=7 CGO_ENABLED=1 \
  CC=/home/nathan/go/src/ClearpathMotors/gcc-linaro-6.1.1-2016.08-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc \
  go build \
  -tags $1 \
  -o ../main ../cmd/server/main.go \
