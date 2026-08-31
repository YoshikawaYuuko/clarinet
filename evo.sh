#!/bin/bash

# init & sync
repo init -u https://github.com/sweet-bullet/evolution_manifest.git -b cnb --git-lfs --depth=1
/opt/crave/resync.sh

# device source
git clone https://github.com/dreamsolister26/android_device_xiaomi_earth.git -b EvolutionX-17 device/xiaomi/earth

# Setup build
. build/envsetup.sh

export BUILD_USERNAME=kumiko
export BUILD_HOSTNAME=crave
export SOONG_NINJA=ninja

# start build 
lunch lineage_earth-cp2a-userdebug
m evolution

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
