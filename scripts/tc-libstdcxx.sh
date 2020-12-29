#! /bin/bash

tar xf ${SRC_PKGS}/gcc* &&
cd gcc* &&
export VER=$(echo $PWD | cut -d - -f 5-)   &&

export CC="${MLFS_TARGET}-gcc"             &&
export CXX="${MLFS_TARGET}-g++"            &&
export AR="${MLFS_TARGET}-ar"              &&
export AS="${MLFS_TARGET}-as"              &&
export RANLIB="${MLFS_TARGET}-ranlib"      &&
export LD="${MLFS_TARGET}-ld"              &&
export STRIP="${MLFS_TARGET}-strip"        &&

for p in ada-shared fix-cxxflags-passing fix-musl-execinfo \
         libgcc-musl-ldbl128-config musl-ada \
         no-stack_chk_fail_local ; do
    patch -Np0 -i ${SRC_PATCHES}/gcc-9.1.0-void/${p}.patch
done &&

mkdir -v build && cd build          &&
../libstdc++-v3/configure           \
    --target=${MLFS_TARGET}         \
    --build=${MLFS_HOST}            \
    --host=${MLFS_TARGET}           \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/${MLFS_TARGET}/include/c++/${VER} &&
make ${MJ} && make install &&
cd ${SRC_ROOT} && rm -rf gcc-*
