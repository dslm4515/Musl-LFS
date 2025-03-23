#! /bin/bash

export PKGNAME="expect"
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
patch -Np1 -i ../patches/expect-5.45.3/dont-put-toolchain-in-libpath.patch &&
patch -Np1 -i ../patches/expect-5.45.3/dont-configure-testsuites.patch     &&
patch -Np1 -i ../patches/expect-5.45.3/allow-cross-compile.patch           &&

cp -v ../files/config.guess-musl tclconfig/config.guess &&
cp -v ../files/config.sub-musl tclconfig/config.sub     &&
cp -v configure{,.orig} &&
sed 's:/usr/local/bin:/bin:' configure.orig > configure &&

./configure --build=${MLFS_HOST} \
            --host=${MLFS_TARGET} \
            --prefix=/tools \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include &&
make ${MJ} &&  make SCRIPTS="" install &&

cd ${SRC_ROOT} && rm -rf ${PKGNAME}*
