# LinuxFSMount
## About
Docker image for mounting Linux FS to do various tasks.

The original intention of this image is to be able to modify the contents of the Raspbian SD image to add/remove components.

## Docker
### Building
```
docker build sabjorn/linuxfsmount .
```

### Running
```
docker run -it --rm -e IMG_NAME=/fs/[img name] -v [host img location]:/fs --privileged sabjorn/linuxfsmount bash
```

### Mounting Images
Images mount autmatically with `entrypoint.sh` as long as `IMG_NAME` is set properly.

**NOTE**: It would be best to make a copy of the filesystem since this container will operate directly on the filesystem. Any modificaitons in `/mnt` will propogate to the `.img` filesystem file.

### Chroot
After mounting the image, you can `chroot` into the filesystem.

#### Linux
`chroot` will work inside this container if the filesystem is of the same architecture. For disparate architectures, take a look at: [multiarch/qemu-user-static](https://hub.docker.com/r/multiarch/qemu-user-static/dockerfile) which allows for QEMU architecture translation within a Docker image. The `qemu-static` binary must be present (or accessable) within the filesystem when `chroot`ing into it.

#### Docker for Mac
In `Docker for Mac`, `QEMU` support is already present and so `chroot`ing into the mounted filesystem should work with any architecture.