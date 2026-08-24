#!/bin/bash

# init & sync
# repo init -u https://github.com/PixelOS-AOSP/android_manifest.git -b seventeen --git-lfs --depth=1
# /opt/crave/resync.sh

# device source
rm -rf device/xiaomi/earth kernel/xiaomi/earth
git clone https://github.com/YoshikawaYuuko/android_device_xiaomi_earth.git -b PixelOS-17 device/xiaomi/earth

# Custom Source 
# rm -rf build/soong
# git clone https://github.com/YoshikawaYuuko/android_build_soong.git -b seventeen build/soong

# Setup build
. build/envsetup.sh

export SOONG_NINJA=ninja
export BUILD_USERNAME=yuuko
export BUILD_HOSTNAME=crave

# start build
breakfast earth userdebug
m pixelos

# Upload
echo "upload to gofile..."
if [ -f out/target/product/earth/*202608*.zip ]; then
    wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
    chmod +x upload.sh ; ./upload.sh out/target/product/earth/*.zip
    echo "upload done!"
else
    echo "no zip found at out/ dir..."
    exit 1
fi
