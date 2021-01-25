## Grow
# simple resize .img filesystem file

IMG_NAME=
COUNT=1000
dd if=/dev/zero bs=512k count=$COUNT >> $IMG_NAME # increase img filesize (pad zeros)

OFFSET=0
losetup -o $OFFSET /dev/loop0 $IMG_NAME
mount /dev/loop0 /mnt # might not be necessary...
resize2fs -f /dev/loop0 # reszie
losetup -c /dev/loop0 # update loopback

## Note, this could work BUT we won't know for sure it's /dev/loop0
# mount -o loop,offset=$OFFSET /mnt

## Note, if losetup is already mounted, run 
# losetup -c /dev/loop0 # update loopback
# resize2fs -f /dev/loop0

## Shrink?
#dd if=${IMG_NAME} of=${IMG_NAME}_shrunk.img bs=512k count=4000
## based on https://softwarebakery.com/shrinking-images-on-linux
# bind loopback
OFFSET=0
losetup -o $OFFSET /dev/loop0 $IMG_NAME
resize2fs -Mf /dev/loop0 # force resize to smallest
losetup -c /dev/loop0 # update loopback
losetup -d /dev/loop0 # unbind loopback

# Shaving the image
fdisk -l ${IMG_NAME}
SECTOR_SIZE=$(fdisk -l ${IMG_NAME} | grep "Units: sectors of" | cut -d " " -f8)
SECTOR_SIZE="${SECTOR_SIZE:-0}"
SECTORS_END=$(echo ${FS_INFO} | cut -d " " -f3)
SECTORS_END="${SECTORS_END:-0}"
truncate --size=$(((${SECTORS_END}+1) * ${SECTOR_SIZE})) ${IMG_NAME}