#! /bin/bash

tar xf ${SRC_PKGS}/binutils* &&
cd binutils* &&

export CC="${MLFS_TARGET}-gcc"             &&
export CXX="${MLFS_TARGET}-g++"            &&
export AR="${MLFS_TARGET}-ar"              &&
export AS="${MLFS_TARGET}-as"              &&
export RANLIB="${MLFS_TARGET}-ranlib"      &&
export LD="${MLFS_TARGET}-ld"              &&
export STRIP="${MLFS_TARGET}-strip"        &&

case ${MLFS_CPU} in
        x86_64) ln -sv lib /tools/lib64 ;;
esac &&

mkdir -v build && cd build                &&
../configure --prefix=/tools            \
             --with-lib-path=/tools/lib \
             --build=${MLFS_HOST}       \
             --host=${MLFS_TARGET}      \
             --target=${MLFS_TARGET}    \
             --disable-nls              \
             --disable-werror           \
             --with-sysroot               &&

make ${MJ} && make install &&
make -C ld clean ${MJ}     &&
make -C ld LIB_PATH=/usr/lib:/lib ${MJ} &&
cp -v ld/ld-new /tools/bin &&
cd ${SRC_ROOT} && rm -rf binutils*
