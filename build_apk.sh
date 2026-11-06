#!/bin/bash
set -e

echo "=== Zigcraft APK Build Script ==="

# Build native library with Zig
echo "Building native library..."
zig build-lib src/android_main.zig \
  -target aarch64-linux-android \
  -dynamic \
  -lc \
  -O ReleaseFast \
  --name zigcraft

# Create jniLibs directory
mkdir -p app/src/main/jniLibs/arm64-v8a
cp libzigcraft.so app/src/main/jniLibs/arm64-v8a/

# Build APK
echo "Building APK..."
./gradlew assembleDebug --stacktrace

echo "=== Build Complete ==="
find app/build -name "*.apk" -type f
