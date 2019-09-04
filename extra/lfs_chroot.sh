#! /bin/bash

# Check if LFS was set
if [ "$1" != "" ]; then
    echo "[  ii  ] Rootfs set at $1 " && 
    echo "[  ii  ] Chroot-ing..." &&
    export LFS=$1 &&
    chroot "$LFS" /usr/bin/env -i          \
    HOME=/root TERM="$TERM"            \
    PS1='(lfs chroot) \u:\w\$ '        \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login &&
    echo "[ DONE ] LFS at $1 was chroot'ed. Exited chroot."
else
    echo "[ STOP ] LFS not set. Please set. Usage: lfs_chroot.sh [rootfs] "
fi
