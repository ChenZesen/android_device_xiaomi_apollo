#!/bin/bash

# Just a basic script U can improvise lateron asper ur need xD 

MANIFEST="https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp -b twrp-11"

DT_PATH=device/xiaomi/apollo
DT_LINK="https://github.com/ChenZesen/android_device_xiaomi_apollo.git -b a11"

echo " ===+++ Setting up Build Environment +++==="
apt install openssh-server tmate -y
apt update --fix-missing
apt install openssh-server tmate -y
mkdir ~/twrp && cd ~/twrp
DEVICE=${DT_PATH##*\/}

echo " ===+++ Syncing Recovery Sources +++==="
repo init --depth=1 -u $MANIFEST
repo sync
git clone --depth=1 $DT_LINK $DT_PATH

echo " ===+++ Building Recovery +++==="
tmate -F
#. build/envsetup.sh
#export ALLOW_MISSING_DEPENDENCIES=true
#lunch twrp_${DEVICE}-eng && mka bootimage

#cd $OUT/recovery/root
#./ldcheck -p system/lib64:vendor/lib64 -d system/bin/qseecomd
#cd -

# Upload zips & boot.img (U can improvise lateron adding telegram support etc etc)
echo " ===+++ Uploading Recovery +++==="
version=$(cat bootable/recovery/variables.h | grep "define TW_MAIN_VERSION_STR" | cut -d \" -f2)
OUTFILE=TWRP-${version}-${DEVICE}-$(date "+%Y%m%d-%I%M").zip
cd out/target/product/$DEVICE
mv boot.img ${OUTFILE%.zip}.img
zip -r9 $OUTFILE ${OUTFILE%.zip}.img

#curl -T $OUTFILE https://oshi.at
curl -sL $OUTFILE https://git.io/file-transfer | sh
./transfer wet *.zip
