#! /bin/bash

export PKGNAME="gettext-tiny"
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

make ${MJ} LIBINTL=MUSL prefix=/tools      &&
cp -v msgfmt msgmerge xgettext /tools/bin  &&
cd ${SRC_ROOT} && rm -rf ${PKGNAME}*
