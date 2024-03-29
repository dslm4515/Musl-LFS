#! /bin/bash

export PKGNAME="vim"
tar xf ${SRC_PKGS}/${PKGNAME}* &&
cd ${PKGNAME}* &&

export CC="${MLFS_TARGET}-gcc"             &&
export CXX="${MLFS_TARGET}-g++"            &&
export AR="${MLFS_TARGET}-ar"              &&
export AS="${MLFS_TARGET}-as"              &&
export RANLIB="${MLFS_TARGET}-ranlib"      &&
export LD="${MLFS_TARGET}-ld"              &&
export STRIP="${MLFS_TARGET}-strip"        &&
export LDFLAGS="-L/tools/lib"      &&
export CPPFLAGS="-I/tools/include" &&
echo "Building $PKGNAME..." &&
./configure --build=${MLFS_HOST} \
            --host=${MLFS_TARGET} \
            --prefix=/tools \
            --disable-gui \
	    --without-x &&
make ${MJ} && make install && unset LDFLAGS CPPFLAGS &&
cd ${SRC_ROOT} && rm -rf ${PKGNAME}*
