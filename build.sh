#!/bin/bash
MANIFEST="https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp -b twrp-11"
 
DT_PATH=device/xiaomi/apollo
DT_LINK="https://github.com/ChenZesen/android_device_xiaomi_apollo.git -b a11"
cd /drone/ 

apt install git aria2 rsync curl sudo wget zstd -y
 
echo "Download the source code"
 
wget -O - "https://github.com/Mikubill/transfer/releases/download/v0.4.11/transfer_0.4.11_linux_amd64.tar.gz" | tar -x --gzip -C /usr/bin/
#transfer https://we.tl/t-rR6yeDNa4Y?src=dnl
#tar axf orangfox.tar.zst
 
echo "Setting Up the Compile Environment "
 
git clone https://gitlab.com/OrangeFox/misc/scripts
bash scripts/setup/android_build_env.sh
#bash scripts/setup/install_android_sdk.sh
#bash scripts/setup/install_android_sdk.sh

echo " ===+++ Syncing Recovery Sources +++==="
repo init --depth=1 -u $MANIFEST
repo sync
git clone --depth=1 $DT_LINK $DT_PATH
