# LinuxFSMount
## About
Docker image for mounting Linux FS to do various tasks.

The original intention of this image is to be able to modify the contents of the Raspbian SD image to add/remove components.

This container can successfully mount a Raspbian .img used. Modifications to the mounted FS will (by default) propogate to the .img file after umounting. *Note*: Modificaitons will only persist if the final .img file is copied out of the container.

## Status
* Only tested with `2018-03-13-raspbian-stretch-lite.img`
* `apt-get` support not working

## Docker
### Building
```
docker build sabjorn/linuxfsmount .
```

### Running
```
docker run -it --rm -e IMG_NAME=[img name] -v [host img location]:/fs --privileged sabjorn/linuxfsmount bash
```
This will mount the `$IMG_NAME` to `/mnt`

## To Do
### Apt-Get Support
`apt-get` will not work without a bit of work for two reasons (maybe more):

**Architecture**: The RPi (likely) uses a different architecture than the host running the docker iamge. [this](https://wiki.debian.org/Multiarch/HOWTO) points to how it should be possible to set a differet arch for `apt-get`.

**Insall Directory**: `apt-get`, even with multi-arch, will not know 