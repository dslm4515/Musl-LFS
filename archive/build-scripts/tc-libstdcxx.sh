#! /bin/bash

tar xf ${SRC_PKGS}/gcc* &&
cd gcc* &&
export VER=$(echo $PWD | cut -d - -f 2 | cut -d _ -f 1 )   &&

export CC="${MLFS_TARGET}-gcc"             &&
export CXX="${MLFS_TARGET}-g++"            &&
export AR="${MLFS_TARGET}-ar"              &&
export AS="${MLFS_TARGET}-as"              &&
export RANLIB="${MLFS_TARGET}-ranlib"      &&
export LD="${MLFS_TARGET}-ld"              &&
export STRIP="${MLFS_TARGET}-strip"        &&

bash ../patches/gcc-10.3.1_git20210424-alpine/apply_patches_ct.sh && \

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
