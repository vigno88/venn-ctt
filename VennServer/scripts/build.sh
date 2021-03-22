#!/bin/bash

# Build go project
env GOOS=linux GOARCH=arm GOARM=7 go build \
  -tags $1 \
  -o ../main ../cmd/server/main.go \
