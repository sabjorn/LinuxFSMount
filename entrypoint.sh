#!/usr/bin/env bash
# About:
# Mounts FS

# NOTE, currently only working for Raspbian
# reference
# cp /ext/2018-03-13-raspbian-stretch-lite.img ./
# losetup -P /dev/loop0 2018-03-13-raspbian-stretch-lite.img 
# fdisk -l 2018-03-13-raspbian-stretch-lite.img 
# mount -v -o offset=$((98304*512)) -t ext4 /dev/loop0 /mnt

if [ -z "$IMG_NAME" ]; then
    echo "IMG_NAME not set, exiting"
    exit 1
fi

cd ${HOME}
cp /fs/${IMG_NAME} ${HOME}
losetup -P /dev/loop0 ${IMG_NAME}

SECTOR_SIZE=$(fdisk -l ${IMG_NAME} | grep "Units: sectors of" | cut -d " " -f8)
FS_INFO=$(fdisk -l ${IMG_NAME} | grep ${IMG_NAME}2)
SECTORS_START=$(echo ${FS_INFO} | cut -d " " -f2)
SECTORS_END=$(echo ${FS_INFO} | cut -d " " -f3)
SECTORS_TOTAL=$(echo ${FS_INFO} | cut -d " " -f4)
mount -v -o offset=$((${SECTORS_START} * ${SECTOR_SIZE})) -t ext4 /dev/loop0 /mnt

exec "$@"

