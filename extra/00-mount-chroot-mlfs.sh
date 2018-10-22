#! /bin/bash

export LFS=/mnt/mlfs

mount -v --bind /dev $LFS/dev
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
# If internet connection needed, uncomment:
mount -v --bind /etc/resolv.conf $LFS/etc/resolv.conf

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

