#! /bin/bash

tar xf ${SRC_PKGS}/musl-1* &&
cd musl-1* &&

./configure \
  CROSS_COMPILE=${MLFS_TARGET}- \
  --prefix=/ \
  --target=${MLFS_TARGET} &&
make ${MJ} && make DESTDIR=/tools install &&

case $(uname -m) in
  x86_64)  rm -v  /tools/lib/ld-musl-x86_64.so.1
           ln -sv libc.so /tools/lib/ld-musl-x86_64.so.1
           export barch=$(uname -m)
           ;;
  i686)    rm -v  /tools/lib/ld-musl-i386.so.1
           ln -sv libc.so /tools/lib/ld-musl-i386.so.1
           export barch=i386
           ;;
  arm*)    rm -v  /tools/lib/ld-musl-arm.so.1
           ln -sv libc.so /tools/lib/ld-musl-arm.so.1
           export barch=arm
           ;;
  aarch64) rm -v /tools/lib/ld-musl-aarch64.so.1
           ln -sv libc.so /tools/lib/ld-musl-aarch64.so.1
           export barch=$(uname -m)
           ;;
esac &&
mkdir -pv /tools/etc &&
echo "/tools/lib" > /tools/etc/ld-musl-${barch}.path &&
unset barch &&
cd ${SRC_ROOT} && rm -rf musl-1*
