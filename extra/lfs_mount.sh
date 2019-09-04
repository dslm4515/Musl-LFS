#! /bin/bash

# Check if LFS was set
if [ "$1" != "" ]; then
    echo "[  ii  ] rootfs set at $1 " && 
    export LFS=$1 &&
    mount -v --bind /dev $LFS/dev &&
    mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620 &&
    mount -vt proc proc $LFS/proc &&
    mount -vt sysfs sysfs $LFS/sys &&
    mount -vt tmpfs tmpfs $LFS/run &&
    if [ -h $LFS/dev/shm ]; then
        mkdir -pv $LFS/$(readlink $LFS/dev/shm)
    fi
    echo "[ DONE ] LFS at $1 is mounted."
else
    echo "[ STOP ] LFS not set. Please set. Usage: lfs_mount [rootfs] "
fi
