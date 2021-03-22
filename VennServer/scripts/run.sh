#!/bin/bash

# Build go project
go run \
  -tags $1 \
  ../cmd/server/main.go \
