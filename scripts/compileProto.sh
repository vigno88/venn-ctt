#!/bin/bash
echo 'Compile proto files'
# Compile dart proto
protoc --dart_out=grpc:../VennUI/lib/grpc/v1 \
  -I../api/ui/proto/v1/ \
  ../api/ui/proto/v1/ui.proto

# Compile golang proto
protoc ui.proto --proto_path=../api/ui/proto/v1 \
  --proto_path=../. \
  --go_out=plugins=grpc:../VennServer/pkg/api/v1
