#! /bin/bash

export PKGNAME="perl"
tar xf ${SRC_PKGS}/${PKGNAME}-5*       &&
tar xf ${SRC_PKGS}/${PKGNAME}-cross*   &&
cd ${PKGNAME}-5* &&
export VER="5.32.0"   &&
export CC="${MLFS_TARGET}-gcc"             &&
export CXX="${MLFS_TARGET}-g++"            &&
export AR="${MLFS_TARGET}-ar"              &&
export AS="${MLFS_TARGET}-as"              &&
export RANLIB="${MLFS_TARGET}-ranlib"      &&
export LD="${MLFS_TARGET}-ld"              &&
export STRIP="${MLFS_TARGET}-strip"        &&

echo "Building $PKGNAME..." &&
cp -r ../perl-cross-*/* ./ &&
patch -p1 < ../patches/perl-5.30-alpine/musl-locale.patch &&
./configure --prefix=/tools \
            --target=${MLFS_TARGET} &&
make ${MJ} && 
cp -v perl cpan/podlators/scripts/pod2man /tools/bin &&
mkdir -pv /tools/lib/perl5/${VER}    &&
cp -Rv lib/* /tools/lib/perl5/${VER} &&
cd ${SRC_ROOT} && rm -rf ${PKGNAME}* ${PKGNAME}-*
