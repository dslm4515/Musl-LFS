#! /bin/bash

export PKGNAME="bzip2"
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
cp Makefile{,.orig}         &&
sed -e "/^all:/s/ test//" Makefile.orig > Makefile    &&
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile   &&
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile &&
make -f Makefile-libbz2_so CC="${CC}" AR="${AR}" RANLIB="${RANLIB}" ${MJ} &&
make ${MJ} clean &&
make CC="${CC}" AR="${AR}" RANLIB="${RANLIB}" ${MJ} &&
make PREFIX=/tools install &&

cd ${SRC_ROOT} && rm -rf ${PKGNAME}*
