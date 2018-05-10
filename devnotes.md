# Dev Notes
## `chroot`
Somehow, mounting `2018-04-18-raspbian-stretch-lite.img` and then running `chroot` (pointing to the directory where the FS was mounted) works on a 2015 MacbookPro, despite the fact that `dpkg --print-architecture` (after running `chroot`) says `armhf`.