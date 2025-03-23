#! /bin/bash

export PKGNAME="findutils"
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
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' gl/lib/*.c               &&
sed -i '/unistd/a #include <sys/sysmacros.h>' gl/lib/mountlist.c &&
echo "#define _IO_IN_BACKUP 0x100" >> gl/lib/stdio-impl.h        &&
./configure --build=${MLFS_HOST} \
            --host=${MLFS_TARGET} \
            --prefix=/tools &&
make ${MJ} && make install &&
cd ${SRC_ROOT} && rm -rf ${PKGNAME}*
