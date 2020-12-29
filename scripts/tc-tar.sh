#! /bin/bash

export PKGNAME="tar-1.3"
tar xf ${SRC_PKGS}/${PKGNAME}* &&
cd ${PKGNAME}* &&

export CC="${MLFS_TARGET}-gcc"             &&
export CXX="${MLFS_TARGET}-g++"            &&
export AR="${MLFS_TARGET}-ar"              &&
export AS="${MLFS_TARGET}-as"              &&
export RANLIB="${MLFS_TARGET}-ranlib"      &&
export LD="${MLFS_TARGET}-ld"              &&
export STRIP="${MLFS_TARGET}-strip"        &&

echo "Building $PKGNAME..." &&
./configure --build=${MLFS_HOST} \
            --host=${MLFS_TARGET} \
            --prefix=/tools &&
make ${MJ} && make install &&
cd ${SRC_ROOT} && rm -rf ${PKGNAME}*
