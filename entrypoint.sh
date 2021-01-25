#!/usr/bin/env bash

if [ -z "$IMG_NAME" ]; then
    echo "IMG_NAME not set, exiting"
    exit 1
fi

# These variables will only populate if the .img is for Raspbian
FS_INFO=$(fdisk -l ${IMG_NAME} | grep ${IMG_NAME}2)
SECTOR_SIZE=$(fdisk -l ${IMG_NAME} | grep "Units: sectors of" | cut -d " " -f8)
SECTOR_SIZE="${SECTOR_SIZE:-0}"
SECTORS_START=$(echo ${FS_INFO} | cut -d " " -f2)
SECTORS_START="${SECTORS_START:-0}"
SECTORS_END=$(echo ${FS_INFO} | cut -d " " -f3)
SECTORS_END="${SECTORS_END:-0}"
SECTORS_TOTAL=$(echo ${FS_INFO} | cut -d " " -f4)

# offset=0 for everything but RPI
mount -o loop,offset=$((${SECTORS_START} * ${SECTOR_SIZE})) $IMG_NAME /mnt

# enable DNS (this file is generally restored by systemd-resolved when actually booting)
cp /etc/resolv.conf /mnt/etc/

if [ ! -z ${ENTER_CHROOT+x} ] ; then
    chroot /mnt "$@"
fi

exec "$@"
