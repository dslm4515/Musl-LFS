#! /bin/bash

export PKGNAME="coreutils"
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
autoreconf -vif &&
patch -Np0 -i ../patches/coreutils-void/0001-ls-restore-8.31-behavior-on-removed-directories.patch &&
printf "fu_cv_sys_stat_statfs2_bsize=no
ac_cv_func_syncfs=no
gl_cv_func_working_mkstemp=yes
gl_cv_func_working_acl_get_file=yes" > config.cache &&
sed -i '/test.lock/s/^/#/' gnulib-tests/gnulib.mk   &&
./configure --build=${MLFS_HOST} \
            --host=${MLFS_TARGET} \
            --prefix=/tools \
            --enable-install-program=hostname \
            --cache-file=config.cache &&
make ${MJ} && make install &&

cd ${SRC_ROOT} && rm -rf ${PKGNAME}*
