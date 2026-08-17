#!/bin/bash

# Export
export ZIPNAME=""
export CODENAME=""
export TIMESTAMP="$(date +"%Y%m%d")-$(date +"%H%M%S")"
export TZ=""
export KBUILD_BUILD_USER="" 
export KBUILD_BUILD_HOST=""	

# setup clang path
export PATH=$PWD/clang/bin:$PATH

# build
make O=out ARCH=arm64 earth_defconfig
make -j$(nproc --all) ARCH=arm64 SUBARCH=arm64 O=out LLVM=1 LLVM_IAS=1
	CC=clang \
	AR=llvm-ar \
	NM=llvm-nm \
	LD=ld.lld \
	OBJCOPY=llvm-objcopy \
	OBJDUMP=llvm-objdump \
	STRIP=llvm-strip \
	CLANG_TRIPLE=aarch64-linux-gnu- \
	CROSS_COMPILE=aarch64-linux-gnu- \
	CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
	CROSS_COMPILE_COMPAT=arm-linux-gnueabi- \
	CONFIG_DEBUG_SECTION_MISMATCH=y
	
# Anykernel
if [ -f out/arch/arm64/boot/Image.gz-dtb ]; then
 cp out/arch/arm64/boot/Image.gz Anykernel3/
 cp out/arch/arm64/boot/dts/mediatek/mt6768.dtb Anykernel3/dtb
 cd Anykernel3
 zip -r9 "../Anykernel3-${ZIPNAME}-${TIMESTAMP}-${CODENAME}.zip" * -x '.git*'
 rm -rf Image.gz dtb
 cd ..
fi
