#!/bin/bash

# clone repo to some folder
# git clone https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

REPO_PATH=/opt/src/linux-firmware
FIRMWARE_LIST="amd,amdtee,amd-ucode,amdgpu,nvidia,cirrus,ath10k,ath11k,ath12k"

IFS=','
for i in ${FIRMWARE_LIST}
do
  echo -e "cloning firmware for ${i}"
  rsync -arhH --info=progress2 ${REPO_PATH}/${i}/. /lib/firmware/${i}/
done

"cloning firmware for iwlwifi"
rsync -arhH --info=progress2 ${REPO_PATH}/iwlwifi-*.{ucode,pnvm} /lib/firmware/

update-initramfs -u -k all
