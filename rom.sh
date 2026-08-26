#!/bin/bash

# init & sync
repo init -u https://github.com/Lunaris-AOSP/android.git -b 16.2 --git-lfs --depth=1
/opt/crave/resync.sh

# device source
git clone https://github.com/YoshikawaYuuko/android_device_xiaomi_earth.git -b Lunaris-16.2 device/xiaomi/earth

# custom personal source
rm -rf vendor/lineage
git clone https://github.com/HiroZukki/vendor_lineage.git -b 16.2 vendor/lineage

export BUILD_USERNAME=yuuko
export BUILD_HOSTNAME=crave

# Setup build
. build/envsetup.sh
lunch lineage_earth-bp4a-user
mka bacon

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
