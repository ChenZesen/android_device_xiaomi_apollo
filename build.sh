apt install git aria2 rsync curl sudo wget zstd -y
cd /drone/
 
echo "Download the source code"
 
wget -O - "https://github.com/Mikubill/transfer/releases/download/v0.4.11/transfer_0.4.11_linux_amd64.tar.gz" | tar -x --gzip -C /usr/bin/
#transfer https://we.tl/t-rR6yeDNa4Y?src=dnl
#tar axf orangfox.tar.zst
 
echo "Setting Up the Compile Environment "
 
git clone https://gitlab.com/OrangeFox/misc/scripts
bash scripts/setup/android_build_env.sh
#bash scripts/setup/install_android_sdk.sh
#bash scripts/setup/install_android_sdk.sh
echo "Start compiling "
 
mkdir ~/OrangeFox_10
cd ~/OrangeFox_10
git clone https://gitlab.com/OrangeFox/sync.git
 
cd ~/OrangeFox_10/sync
./get_fox_10.sh ~/OrangeFox_10/fox_10.0
 
rm -rf ~/OrangeFox_10/fox_10.0/.repo
mv ~/OrangeFox_10/fox_10.0 /drone/
cd /drone
 
cd fox_10.0
 
cp -r /drone/src device/xiaomi/apollo
 
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL="C"
lunch omni_apollo-eng && mka recoveryimage

echo "上传下载链接 "
transfer wet /drone/fox_10.0/out/target/product/apollo/*.zip
