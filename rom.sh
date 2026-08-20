#!/bin/bash

# init & sync
repo init -u https://github.com/Evolution-X/manifest.git -b bka --git-lfs --depth=1
/opt/crave/resync.sh

# device source
git clone https://github.com/YoshikawaYuuko/android_device_xiaomi_earth.git -b EvolutionX-16 device/xiaomi/earth

export BUILD_USERNAME=yuuko
export BUILD_HOSTNAME=crave

. build/envsetup.sh
lunch lineage_earth-bp4a-userdebug
m evolution

# Upload
echo "upload to gofile..."
if [ -f out/target/product/earth/*202608*.zip ]; then
    wget https://raw.githubusercontent.com/lordgaruda/GoFile-Upload/refs/heads/master/upload.sh
    chmod +x upload.sh ; ./upload.sh out/target/product/earth/*.zip
    echo "upload done!"
else
    echo "no zip found at out/ dir..."
fi
