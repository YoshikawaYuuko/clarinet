#!/bin/bash

# init & sync
repo init -u https://github.com/sweet-bullet/voltage_manifest.git -b 17 --git-lfs --depth=1
/opt/crave/resync.sh

# device source
git clone https://github.com/dreamsolister26/android_device_xiaomi_earth.git -b Voltage-17 device/xiaomi/earth

export BUILD_USERNAME=yuuko
export BUILD_HOSTNAME=crave

# Setup build
. build/envsetup.sh
brunch earth userdebug  

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
