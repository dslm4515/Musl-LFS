#! /bin/bash

# Check if LFS was set
if [ "$1" != "" ]; then
    echo "[  ii  ] rootfs set at $1 " && 
    export LFS=$1 &&
    umount -v $LFS/dev/pts &&
    umount -v $LFS/dev &&
    umount -v $LFS/run &&
    umount -v $LFS/proc &&
    umount -v $LFS/sys &&
    echo "[ DONE ] LFS at $1 is unmounted."
else
    echo "[ STOP ] LFS not set. Please set. Usage: lfs_umount [rootfs] "
fi
