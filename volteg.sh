#!/bin/bash

# init & sync
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs --no-clone-bundle --depth=1
/opt/crave/resync.sh

# device source
git clone https://github.com/dreamsolister26/android_device_xiaomi_earth.git -b lineage-22.2 device/xiaomi/earth
git clone https://github.com/dreamsolister26/proprietary_vendor_xiaomi_earth.git -b lineage-22.2 vendor/xiaomi/earth
git clone https://github.com/LineageOS/android_kernel_xiaomi_earth.git -b lineage-22.1 kernel/xiaomi/earth --depth=1
git clone https://github.com/dreamsolister26/fortissimo.git -b keys-new vendor/lineage-priv/keys
git clone https://github.com/LineageOS/android_hardware_xiaomi.git -b lineage-22.2 hardware/xiaomi
git clone https://github.com/LineageOS/android_hardware_mediatek.git -b lineage-22.2 hardware/mediatek
git clone https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr.git -b lineage-22.2 device/mediatek/sepolicy_vndr

# Setup build
. build/envsetup.sh

export BUILD_USERNAME=yuuko
export BUILD_HOSTNAME=crave
export TARGET_ENABLE_BLUR=false
export TARGET_DISABLE_MATLOG=true

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
