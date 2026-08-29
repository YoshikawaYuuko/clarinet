#!/bin/bash

rm -rf device/xiaomi/earth vendor/xiaomi/earth kernel/xiaomi/earth vendor/lineage-priv/keys
rm -rf hardware/mediatek hardware/xiaomi device/mediatek/sepolicy_vndr

# init & sync
repo init -u https://github.com/sweet-bullet/pixelos_manifest.git -b seventeen --git-lfs --depth=1
/opt/crave/resync.sh

# device source
git clone https://github.com/YoshikawaYuuko/android_device_xiaomi_earth.git -b PixelOS-17 device/xiaomi/earth

# Setup build
. build/envsetup.sh

export SOONG_NINJA=ninja
export BUILD_USERNAME=yuuko
export BUILD_HOSTNAME=crave

# start build
breakfast earth userdebug
make installclean 
m pixelos

# Upload
echo "upload to gofile..."
if [ -f out/target/product/earth/*202608*.zip ]; then
    wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
    chmod +x upload.sh ; ./upload.sh out/target/product/earth/PixelOS_*.zip
    echo "upload done!"
else
    echo "no zip found at out/ dir..."
    exit 1
fi
