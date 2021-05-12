#!/bin/bash

# Build asset bundle
flutter build bundle

# Build kernel snapshot 
~/snap/flutter/common/flutter/bin/cache/dart-sdk/bin/dart \
  ~/snap/flutter/common/flutter/bin/cache/dart-sdk/bin/snapshots/frontend_server.dart.snapshot \
  --sdk-root /home/nathan/snap/flutter/common/flutter/bin/cache/artifacts/engine/common/flutter_patched_sdk_product \
  --target=flutter \
  --aot \
  --tfa \
  -Ddart.vm.product=true \
  --packages .packages \
  --output-dill build/kernel_snapshot.dill \
  --verbose \
  --depfile build/kernel_snapshot.d \
  package:VennUI/main.dart
# Build app.so
~/engine-binaries/arm/gen_snapshot_linux_x64_release \
  --deterministic \
  --snapshot_kind=app-aot-elf \
  --elf=build/flutter_assets/app.so \
  --strip \
  --sim_use_hardfp \
  build/kernel_snapshot.dill
