#! /bin/bash

#tar xf ${SRC_PKGS}/linux-* &&
cd linux-* &&

export CC="${MLFS_TARGET}-gcc"             &&
export CXX="${MLFS_TARGET}-g++"            &&
export AR="${MLFS_TARGET}-ar"              &&
export AS="${MLFS_TARGET}-as"              &&
export RANLIB="${MLFS_TARGET}-ranlib"      &&
export LD="${MLFS_TARGET}-ld"              &&
export STRIP="${MLFS_TARGET}-strip"        &&

make mrproper ${MJ}                        &&
ARCH=${MLFS_ARCH} make headers ${MJ}       &&
find usr/include \( -name .install -o -name ..install.cmd \) -delete &&
cp -rv usr/include/* /tools/include &&
rm -v /tools/include/Makefile       &&

cd ${SRC_ROOT} 
