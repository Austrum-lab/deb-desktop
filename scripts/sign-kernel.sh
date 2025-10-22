#!/usr/bin/env bash

MOK_FOLDER=/opt/_src
MOK_NAME=MOK
SIGN_TOOL="/usr/src/linux-headers-$(uname -r)/scripts/sign-file"

# sudo apt install sbsigntool
# openssl req -new -x509 -newkey rsa:4096 -keyout ${MOK_FOLDER}/${MOK_NAME}/.priv.pem -out ${MOK_FOLDER}/${MOK_NAME}/.crt.pem -nodes -days 3650 -subj "/CN=TKG Kernel ${MOK_FOLDER}/${MOK_NAME}//"
#openssl x509 -in ${MOK_FOLDER}/${MOK_NAME}/.crt.pem -outform DER -out ${MOK_FOLDER}/${MOK_NAME}/.crt.der
#sudo mokutil --import ${MOK_FOLDER}/${MOK_NAME}/.crt.der
# reboot -> Enroll ${MOK_FOLDER}/${MOK_NAME}/ -> continue -> password -> enter -> continue

mv /boot/vmlinuz-$(uname -r) /boot/bak-vmlinuz-$(uname -r).bak
sbsign --key ${MOK_FOLDER}/${MOK_NAME}/.priv.pem --cert ${MOK_FOLDER}/${MOK_NAME}/.crt.pem --output /boot/vmlinuz-$(uname -r) /boot/bak-vmlinuz-$(uname -r).bak


for MOD in $(find /lib/modules/$(uname -r)/updates/dkms/ -name "*.ko"); do
  ${SIGN_TOOL} sha256 ${MOK_FOLDER}/${MOK_NAME}/.priv.pem ${MOK_FOLDER}/${MOK_NAME}/.crt.pem ${MOD}
done

sudo update-grub


#${SIGN_TOOL} sha256 ${MOK_FOLDER}/${MOK_NAME}/.priv.pem ${MOK_FOLDER}/${MOK_NAME}/.crt.pem /lib/modules/$(uname -r)/updates/dkms/nvidia.ko
#${SIGN_TOOL} sha256 ${MOK_FOLDER}/${MOK_NAME}/.priv.pem ${MOK_FOLDER}/${MOK_NAME}/.crt.pem /lib/modules/$(uname -r)/updates/dkms/nvidia-drm.ko
#${SIGN_TOOL} sha256 ${MOK_FOLDER}/${MOK_NAME}/.priv.pem ${MOK_FOLDER}/${MOK_NAME}/.crt.pem /lib/modules/$(uname -r)/updates/dkms/nvidia-modeset.ko
#${SIGN_TOOL} sha256 ${MOK_FOLDER}/${MOK_NAME}/.priv.pem ${MOK_FOLDER}/${MOK_NAME}/.crt.pem /lib/modules/$(uname -r)/updates/dkms/nvidia-peermem.ko
#${SIGN_TOOL} sha256 ${MOK_FOLDER}/${MOK_NAME}/.priv.pem ${MOK_FOLDER}/${MOK_NAME}/.crt.pem /lib/modules/$(uname -r)/updates/dkms/nvidia-uvm.ko
#${SIGN_TOOL} sha256 ${MOK_FOLDER}/${MOK_NAME}/.priv.pem ${MOK_FOLDER}/${MOK_NAME}/.crt.pem /lib/modules/$(uname -r)/kernel/drivers/platform/x86/nvidia-wmi-ec-backlight.ko.zst
